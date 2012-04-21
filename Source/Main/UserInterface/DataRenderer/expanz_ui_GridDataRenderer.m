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

- (void) checkForFieldNamesToRenderFor:(UITableView*)tableView;

- (void) populateCel:(ThumbnailTableCell*)cell withDataFrom:(AbstractGridDataCell*)abstractCell;

- (ThumbnailTableCell*) dequeueTableCellFor:(UITableView*)tableView reuseId:(NSString*)reuseId;

- (Row*) tableView:(UITableView*)tableView rowForIndexPath:(NSIndexPath*)indexPath;

- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;

@end
/* ================================================================================================================== */

@implementation expanz_ui_GridDataRenderer

@synthesize tableCell = _tableCell;

/* ================================================== Initializers ================================================== */
- (id) initWithData:(expanz_model_AbstractData*)data tableView:(UITableView*)tableView
        activityName:(NSString*)activityName {

    self = [super initWithData:data tableView:tableView activityName:activityName];
    if (self) {
        _gridData = (GridData*) self.data;
        _observedCells = [[NSMutableArray alloc] init];
        _shouldCheckForFieldNamesToRender = YES;
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

    Row* row = [self tableView:tableView rowForIndexPath:indexPath];

    if (_shouldCheckForFieldNamesToRender) {
        [self checkForFieldNamesToRenderFor:tableView];
    }

    if (_hasFieldNames) {
        LogDebug(@"Populating cell with fieldNames: %@", _fieldNames);
        for (NSString* fieldName in _fieldNames) {
            AbstractGridDataCell* abstractCell = [row cellForFieldId:fieldName];
            [self populateCel:cell withDataFrom:abstractCell];
        }
    }
    else {
        NSArray* abstractCells = [row cells];
        for (AbstractGridDataCell* abstractCell in abstractCells) {
            [self populateCel:cell withDataFrom:abstractCell];
        }
    }

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
- (void) checkForFieldNamesToRenderFor:(UITableView*)tableView {
    _fieldNames = [tableView fieldNames];
    if (_fieldNames != nil) {
        _hasFieldNames = YES;
    }
    _shouldCheckForFieldNamesToRender = NO;
}

- (void) populateCel:(ThumbnailTableCell*)cell withDataFrom:(AbstractGridDataCell*)gridDataCell {

    if ([gridDataCell isKindOfClass:[ImageGridDataCell class]] && cell.thumbnail.image == nil) {
        ImageGridDataCell* imageCell = (ImageGridDataCell*) gridDataCell;
        cell.thumbnail.image = [UIImage imageWithData:imageCell.imageData];
        if (cell.thumbnail.image == nil) {
            LogDebug(@"Observing cell for an image. . . ");
            [imageCell addObserver:self forKeyPath:@"imageData" options:0 context:(__bridge void*) cell];
        }
        if (imageCell.hasAskedImageToLoad == NO) {
            [imageCell loadImage];
            [_observedCells addObject:imageCell];
        }
        else {
            LogDebug(@"Image already loaded. . . ");
        }
    }
    else if ([gridDataCell isKindOfClass:[TextGridDataCell class]]) {
        TextGridDataCell* textCell = (TextGridDataCell*) gridDataCell;
        if (cell.mainLabel.text == nil) {
            cell.mainLabel.text = textCell.text;
        }
        else if (cell.subLabel.text == nil) {
            cell.subLabel.text = textCell.text;
        }
    }
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

    for (Row* row in [_gridData rows]) {

        NSComparisonResult result;
        int searchOptions = (NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch);
        for (TextGridDataCell* cell in [row textCells]) {
            result = [cell.text compare:searchText options:searchOptions range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame) {
                [_filteredListContent addObject:row];
                break;
            }
        }
    }
}


@end