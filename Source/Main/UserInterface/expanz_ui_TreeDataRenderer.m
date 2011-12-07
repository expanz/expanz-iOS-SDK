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

@implementation expanz_ui_TreeDataRenderer

@synthesize tableCell = _tableCell;

/* ================================================== Initializers ================================================== */
- (id)initWithData:(expanz_model_AbstractData*)data tableView:(UITableView*)tableView
      activityName:(NSString*)activityName {

    self = [super initWithData:data tableView:tableView activityName:activityName];
    if (self) {
        _treeData = (TreeData*) self.data;
    }
    return self;
}


/* ================================================= Protocol Methods =============================================== */
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    Folder* folder = [[_treeData folders] objectAtIndex:section];
    return [folder title];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return [[_treeData folders] count];
}


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    Folder* folder = [[_treeData folders] objectAtIndex:section];
    return [[folder files] count];
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    NSString* reuseId = [_treeData dataId];

    ThumbnailTableCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TreeDataTableCell" owner:self options:nil];
        cell = self.tableCell;
        self.tableCell = nil;
    }

    Folder* folder = [[_treeData folders] objectAtIndex:indexPath.section];
    File* file = [[folder files] objectAtIndex:indexPath.row];

    cell.mainLabel.text = file.title;

    cell.backgroundView.backgroundColor =
        (indexPath.row % 2) ? [UIColor colorWithRed:0.89 green:0.957 blue:0.918 alpha:1] /*#e3f4ea*/ :
            [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1];

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    Folder* folder = [[_treeData folders] objectAtIndex:indexPath.section]; 
    File* file = [[folder files] objectAtIndex:indexPath.row];    
    if ([self.activityManager showDocument:file.fileId]) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44;
}


/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [super dealloc];
}

@end