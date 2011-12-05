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

#import <Foundation/Foundation.h>

@class expanz_ui_ActivityManager;
@class expanz_model_TreeData;
@class expanz_ui_components_ThumbnailTableCell;
@class expanz_ui_components_TreeDataTableCell;


@interface expanz_ui_TreeDataRenderer : NSObject <UITableViewDataSource, UITableViewDelegate> {

@private
    expanz_ui_ActivityManager* _activityManager;
}

/**
* Data to be rendered.
*/
@property(nonatomic, readonly) expanz_model_TreeData* treeData;

/**
* UITableView to display the data.
*/
@property(nonatomic, readonly) UITableView* tableView;

/**
* Activity name to use for showing detail of a grid data row.
*/
@property(nonatomic, readonly) NSString* activityName;

/**
* Injection point for loading custom table cells from a nib.
*/
@property(nonatomic, assign) IBOutlet expanz_ui_components_TreeDataTableCell* tableCell;

/**
* Initializes the renderer with data.
*/
- (id)initWithTreeData:(expanz_model_TreeData*)gridData tableView:(UITableView*)tableView
          activityName:(NSString*)activityName;


@end

/* ================================================================================================================== */
@compatibility_alias TreeDataRenderer expanz_ui_TreeDataRenderer;


