////////////////////////////////////////////////////////////////////////////////
//
//  EXPANZ
//  Copyright 2008-2011 EXPANZ
//  All Rights Reserved.
//
//  NOTICE: Expanz permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "expanz_ui_GridDataRenderer.h"
#import "expanz_ui_components_ThumbnailTableCell.h"
#import "expanz_model_Row.h"
#import "expanz_model_TextGridDataCell.h"
#import "expanz_model_ImageGridDataCell.h"
#import "expanz_model_MenuItem.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_model_GridData.h"
#import "UITableView+DataPublication.h"


@interface expanz_ui_GridDataRenderer (Private)

- (void) storeFieldNamesToRenderOn:(UITableView*)tableView;

- (ThumbnailTableCell*) dequeueTableCellFor:(UITableView*)tableView reuseId:(NSString*)reuseId;

- (Row*) tableView:(UITableView*)tableView rowForIndexPath:(NSIndexPath*)indexPath;

- (void) thumbnailTableViewCell:(ThumbnailTableCell*)cell setThumbnailImageFor:(Row*)row;

@end

/* ================================================================================================================== */

@implementation expanz_ui_GridDataRenderer

@synthesize mainLabelFieldId = _mainLabelFieldId;
@synthesize subLabelFieldId = _subLabelFieldId;
@synthesize thumbnailFieldId = _thumbnailFieldId;


/* ================================================== Initializers ================================================== */
- (id) initWithData:(expanz_model_AbstractData*)data tableView:(UITableView*)tableView
        activityName:(NSString*)activityName {

    self = [super initWithData:data tableView:tableView activityName:activityName];
    if (self) {
        _gridData = (GridData*) self.data;
        _observedCells = [[NSMutableArray alloc] init];
        _shouldStoreFieldIdentifiersToRender = YES;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {

    if (tableView == self.searchController.searchResultsTableView) {
        return [_filteredListContent count];
    }
    else {
        return [[_gridData rows] count];
    }
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {

    ThumbnailTableCell* cell = [self dequeueTableCellFor:tableView reuseId:[_gridData dataId]];
    [self setBackgroundColorForIndexPath:indexPath OnCell:cell];

    if (_shouldStoreFieldIdentifiersToRender) {
        [self storeFieldNamesToRenderOn:tableView];
    }

    Row* row = [self tableView:tableView rowForIndexPath:indexPath];

    [self thumbnailTableViewCell:cell setThumbnailImageFor:row];
    cell.mainLabel.text = ((TextGridDataCell*) [row cellForFieldId:_mainLabelFieldId]).text;
    cell.subLabel.text = ((TextGridDataCell*) [row cellForFieldId:_subLabelFieldId]).text;

    return cell;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    Row* row = [self tableView:tableView rowForIndexPath:indexPath];

    MenuItem* menuItem =
            [[MenuItem alloc] initWithActivityId:self.activityName title:@"Edit" style:[ActivityStyle defaultStyle]];
    if ([[NavigationManager sharedNavigationManager] showActivityFor:menuItem initialKey:row.rowId]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

/* ================================================================================================================== */
#pragma mark Add Images as they Load

- (void) thumbnailTableViewCell:(ThumbnailTableCell*)cell setThumbnailImageFor:(Row*)row {
    if ([_thumbnailFieldId length] > 0) {
        ImageGridDataCell* imageCell = (ImageGridDataCell*) [row cellForFieldId:_thumbnailFieldId];
        cell.thumbnail.image = [UIImage imageWithData:imageCell.imageData];
        if (cell.thumbnail.image == nil) {
            LogDebug(@"Observing cell for an image that hasn't loaded yet.");
            [imageCell addObserver:self forKeyPath:@"imageData" options:0 context:(__bridge void*) cell];
            [_observedCells addObject:imageCell];
            if (imageCell.hasAskedImageToLoad == NO) {
                [imageCell loadImage];
            }
        }
    }
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change
        context:(void*)context {

    ThumbnailTableCell* tableCell = (__bridge ThumbnailTableCell*) context;
    ImageGridDataCell* gridDataCell = (ImageGridDataCell*) object;

    tableCell.thumbnail.image = [UIImage imageWithData:gridDataCell.imageData];
    [gridDataCell removeObserver:self forKeyPath:@"imageData"];
}

/* ================================================================================================================== */
#pragma mark Content Filtering for UISearchDisplayController delegate

- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {

    LogDebug(@"Let's get some filter action!!!!");

    [_filteredListContent removeAllObjects];
    NSRange searchTextRange = NSMakeRange(0, [searchText length]);
    int searchOptions = [self searchOptions];

    for (Row* row in [_gridData rows]) {

        NSString* titleText = [(TextGridDataCell*) [row cellForFieldId:_mainLabelFieldId] text];
        NSString* detailText = [(TextGridDataCell*) [row cellForFieldId:_subLabelFieldId] text];

        NSComparisonResult matchTitle = [titleText compare:searchText options:searchOptions range:searchTextRange];
        NSComparisonResult matchDetail = [detailText compare:searchText options:searchOptions range:searchTextRange];


        if ((titleText && matchTitle == NSOrderedSame) || (detailText && matchDetail == NSOrderedSame)) {
            [_filteredListContent addObject:row];
        }
    }
}

- (NSString*) nibNameForTableCell {
    if ([_nibNameForTableCell length] == 0) {
        _nibNameForTableCell = @"DefaultTableCellForGridData";
    }
    return _nibNameForTableCell;
}


/* ================================================== Private Methods =============================================== */
- (void) storeFieldNamesToRenderOn:(UITableView*)tableView {
    NSArray* candidateFieldNames = [tableView fieldNames];
    if ([candidateFieldNames count] == 0) {
        candidateFieldNames = [_gridData fieldIdentifiers];
    }LogDebug(@"Candidate field names: %@", candidateFieldNames);

    for (NSString* fieldName in candidateFieldNames) {
        AbstractGridDataCell* cell = [[[_gridData rows] objectAtIndex:0] cellForFieldId:fieldName];
        if ([cell isKindOfClass:[ImageGridDataCell class]] && [_thumbnailFieldId length] == 0) {
            _thumbnailFieldId = fieldName;
            LogDebug(@"Thumbnail field ID will be: %@", _thumbnailFieldId);
        }
        else if ([cell isKindOfClass:[TextGridDataCell class]] && [_mainLabelFieldId length] == 0) {
            _mainLabelFieldId = fieldName;
            LogDebug(@"Main label field ID will be: %@", _mainLabelFieldId);
        }
        else if ([cell isKindOfClass:[TextGridDataCell class]] && [_subLabelFieldId length] == 0) {
            _subLabelFieldId = fieldName;
            LogDebug(@"Detail label field ID will be: %@", _subLabelFieldId);
        }
    }
    _shouldStoreFieldIdentifiersToRender = NO;
}

- (ThumbnailTableCell*) dequeueTableCellFor:(UITableView*)tableView reuseId:(NSString*)reuseId {
    ThumbnailTableCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = (ThumbnailTableCell*) [self loadTableCellFromNib];
    }
    cell.thumbnail.image = nil;
    cell.mainLabel.text = nil;
    cell.subLabel.text = nil;
    return cell;
}

- (Row*) tableView:(UITableView*)tableView rowForIndexPath:(NSIndexPath*)indexPath {
    Row* row;
    if (tableView == self.searchController.searchResultsTableView) {
        LogDebug(@"Return da filter results");
        row = [_filteredListContent objectAtIndex:indexPath.row];
    }
    else {
        row = [_gridData.rows objectAtIndex:indexPath.row];
    }
    return row;
}

@end