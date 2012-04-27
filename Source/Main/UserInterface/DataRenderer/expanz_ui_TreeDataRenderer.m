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

#import "expanz_model_TreeData.h"
#import "expanz_model_Folder.h"
#import "expanz_model_File.h"
#import "expanz_ui_TreeDataRenderer.h"
#import "expanz_ui_components_ThumbnailTableCell.h"
#import "expanz_ui_NavigationManager.h"

@interface expanz_ui_TreeDataRenderer (Private)

- (ThumbnailTableCell*) dequeueTableCellFor:(UITableView*)tableView reuseId:(NSString*)reuseId;

- (File*) tableView:(UITableView*)tableView fileForIndexPath:(NSIndexPath*)indexPath;

@end


@implementation expanz_ui_TreeDataRenderer

@synthesize tableCell = _tableCell;

/* ================================================== Initializers ================================================== */
- (id) initWithData:(expanz_model_AbstractData*)data tableView:(UITableView*)tableView
        activityName:(NSString*)activityName {

    self = [super initWithData:data tableView:tableView activityName:activityName];
    if (self) {
        _treeData = (TreeData*) self.data;
    }
    return self;
}


/* ================================================= Protocol Methods =============================================== */
- (NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {

    if (tableView == self.searchController.searchResultsTableView) {
        return nil;
    }
    else {
        Folder* folder = [[_treeData folders] objectAtIndex:section];
        return [folder title];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView {
    if (tableView == self.searchController.searchResultsTableView) {
        return 1;
    }
    else {
        return [[_treeData folders] count];
    }
}

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchController.searchResultsTableView) {
        return [_filteredListContent count];
    }
    else {
        Folder* folder = [[_treeData folders] objectAtIndex:section];
        return [[folder files] count];

    }
}


- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {

    ThumbnailTableCell* cell = [self dequeueTableCellFor:tableView reuseId:[_treeData dataId]];
    [self setBackgroundColorForIndexPath:indexPath OnCell:cell];

    File* file = [self tableView:tableView fileForIndexPath:indexPath];
    cell.mainLabel.text = file.title;
    return cell;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    File* file = [self tableView:tableView fileForIndexPath:indexPath];
    if ([self.activityManager showDocument:file.fileId]) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44;
}

/* ================================================================================================================== */
#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {

    [_filteredListContent removeAllObjects];
    NSRange searchTextRange = NSMakeRange(0, [searchText length]);
    int searchOptions = [self searchOptions];

    for (Folder* folder in [_treeData folders]) {
        for (File* file in [folder files]) {
            if (([file.title compare:searchText options:searchOptions range:searchTextRange]) == NSOrderedSame) {
                [_filteredListContent addObject:file];
            }
        }
    }
}

/* ================================================== Private Methods =============================================== */
- (ThumbnailTableCell*) dequeueTableCellFor:(UITableView*)tableView reuseId:(NSString*)reuseId {
    ThumbnailTableCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TableCellForTreeData" owner:self options:nil];
        cell = self.tableCell;
        self.tableCell = nil;
    }
    return cell;
}

- (File*) tableView:(UITableView*)tableView fileForIndexPath:(NSIndexPath*)indexPath {
    File* file;
    if (tableView == self.searchController.searchResultsTableView) {
        file = [_filteredListContent objectAtIndex:indexPath.row];
    }
    else {
        LogDebug(@"Here we go!");
        Folder* folder = [[_treeData folders] objectAtIndex:indexPath.section];

        LogDebug(@"Folder has files: %i", [[folder files] count]);
        LogDebug(@"IndexPath.section: %i, indexPath.row: %i", indexPath.section, indexPath.row);

        file = [[folder files] objectAtIndex:indexPath.row];
    }
    return file;
}


@end