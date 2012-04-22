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

- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;

@end
/* ================================================================================================================== */

@implementation expanz_ui_GridDataRenderer

@synthesize tableCell = _tableCell;
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
        return [_gridData.rows count];
    }

}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {

    ThumbnailTableCell* cell = [self dequeueTableCellFor:tableView reuseId:[_gridData dataId]];
    if (indexPath.row % 2) {
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1];
    }

    if (_shouldStoreFieldIdentifiersToRender) {
        [self storeFieldNamesToRenderOn:tableView];
    }

    Row* row = [self tableView:tableView rowForIndexPath:indexPath];

    if ([_thumbnailFieldId length] > 0) {
        ImageGridDataCell* imageCell = [row cellForFieldId:_thumbnailFieldId];
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

    cell.mainLabel.text = ((TextGridDataCell*) [row cellForFieldId:_mainLabelFieldId]).text;
    cell.subLabel.text = ((TextGridDataCell*) [row cellForFieldId:_subLabelFieldId]).text;

    return cell;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    Row* row = [self tableView:tableView rowForIndexPath:indexPath];

    MenuItem* edit =
            [[MenuItem alloc] initWithActivityId:self.activityName title:@"Edit" style:[ActivityStyle defaultStyle]];
    if ([self.activityManager showActivity:edit initialKey:row.rowId]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 75;
}

/* ================================================================================================================== */
#pragma mark Add Images as they Load

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change
        context:(void*)context {

    ThumbnailTableCell* tableCell = (__bridge ThumbnailTableCell*) context;
    ImageGridDataCell* gridDataCell = (ImageGridDataCell*) object;

    tableCell.thumbnail.image = [UIImage imageWithData:gridDataCell.imageData];
    [gridDataCell removeObserver:self forKeyPath:@"imageData"];
}

/* ================================================================================================================== */
#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL) searchDisplayController:(UISearchDisplayController*)controller
        shouldReloadTableForSearchString:(NSString*)searchString {

    NSArray* scope = [self.searchController.searchBar scopeButtonTitles];
    NSInteger selectedScopeButtonIndex = [self.searchController.searchBar selectedScopeButtonIndex];
    [self filterContentForSearchText:searchString scope:[scope objectAtIndex:selectedScopeButtonIndex]];
    return YES;
}


- (BOOL) searchDisplayController:(UISearchDisplayController*)controller
        shouldReloadTableForSearchScope:(NSInteger)searchOption {

    NSString* searchText = [self.searchController.searchBar text];
    NSArray* searchScope = [self.searchController.searchBar scopeButtonTitles];
    [self filterContentForSearchText:searchText scope:[searchScope objectAtIndex:searchOption]];
    return YES;
}


/* ================================================== Private Methods =============================================== */
- (void) storeFieldNamesToRenderOn:(UITableView*)tableView {
    NSArray* candidateFieldNames = [tableView fieldNames];
    if ([candidateFieldNames count] == 0) {
        candidateFieldNames = [_gridData fieldIdentifiers];
    }
    LogDebug(@"Candidate field names: %@", candidateFieldNames);

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
        [[NSBundle mainBundle] loadNibNamed:@"TableCellForGridData" owner:self options:nil];
        cell = self.tableCell;
        self.tableCell = nil;
    }
    cell.thumbnail.image = nil;
    cell.mainLabel.text = nil;
    cell.subLabel.text = nil;
    return cell;
}

- (Row*) tableView:(UITableView*)tableView rowForIndexPath:(NSIndexPath*)indexPath {
    Row* row;
    if (tableView == self.searchController.searchResultsTableView) {
        row = [_filteredListContent objectAtIndex:indexPath.row];
    }
    else {
        row = [_gridData.rows objectAtIndex:indexPath.row];
    }
    return row;
}

- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {

    [_filteredListContent removeAllObjects];
    int searchOptions = (NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch);
    NSRange searchTextRange = NSMakeRange(0, [searchText length]);

    for (Row* row in [_gridData rows]) {
        NSString* mainLabeltext = [(TextGridDataCell*) [row cellForFieldId:_mainLabelFieldId] text];
        NSString* subLabelText = [(TextGridDataCell*) [row cellForFieldId:_subLabelFieldId] text];

        NSComparisonResult matchMain = [mainLabeltext compare:searchText options:searchOptions range:searchTextRange];
        NSComparisonResult matchSub = [subLabelText compare:searchText options:searchOptions range:searchTextRange];

        if (matchMain == NSOrderedSame || matchSub == NSOrderedSame) {
            [_filteredListContent addObject:row];
        }
    }
}


@end