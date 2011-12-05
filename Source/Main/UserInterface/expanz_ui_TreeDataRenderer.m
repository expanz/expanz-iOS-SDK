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
#import <Objection-iOS/JSObjectFactory.h>
#import <Objection-iOS/JSObjection.h>
#import "expanz_model_TreeData.h"
#import "expanz_model_Folder.h"
#import "expanz_model_File.h"
#import "expanz_ui_TreeDataRenderer.h"
#import "expanz_ui_ActivityManager.h"
#import "expanz_ui_components_TreeDataTableCell.h"

@implementation expanz_ui_TreeDataRenderer

@synthesize treeData = _treeData;
@synthesize tableView = _tableView;
@synthesize activityName = _activityName;
@synthesize tableCell = _tableCell;

/* ================================================== Constructors ================================================== */
- (id)initWithTreeData:(expanz_model_TreeData*)gridData tableView:(UITableView*)tableView
          activityName:(NSString*)activityName {
    self = [super init];
    if (self) {
        _treeData = gridData;
        _tableView = tableView;
        _activityName = [activityName copy];
        _activityManager = [[JSObjection globalInjector] getObject:[ActivityManager class]];
    }
    return self;
}

/* ================================================= Protocol Methods =============================================== */
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    Folder* folder = [[_treeData folders] objectAtIndex:section];
    LogDebug(@"Folder: %@", [folder title]);
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

    TreeDataTableCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TreeDataTableCell" owner:self options:nil];
        cell = self.tableCell;
        self.tableCell = nil;
    }

    Folder* folder = [[_treeData folders] objectAtIndex:indexPath.section];
    File* file = [[folder files] objectAtIndex:indexPath.row];

    cell.mainLabel.text = file.title;
    cell.subLabel.text = file.fileName;

    cell.backgroundView.backgroundColor =
        (indexPath.row % 2) ? [UIColor colorWithRed:0.89 green:0.957 blue:0.918 alpha:1] /*#e3f4ea*/ :
            [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1];

    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
//    Row* row = [_gridData.rows objectAtIndex:indexPath.row];
//
//    ActivityDefinition* edit =
//        [[ActivityDefinition alloc] initWithName:_activityName title:@"Edit" style:[ActivityStyle defaultStyle]];
//    if ([_activityManager transitionToActivityWithDefinition:edit initialKey:row.rowId]) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    }
}

- (CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44;
}



/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [_activityName release];
    [super dealloc];
}

@end