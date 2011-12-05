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

@class expanz_model_AbstractData;
@class expanz_ui_ActivityManager;


@interface expanz_ui_AbstractDataRenderer : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, readonly) expanz_ui_ActivityManager* activityManager;

/**
* Data to be rendered.
*/
@property(nonatomic, readonly) expanz_model_AbstractData* data;

/**
* UITableView to display the data.
*/
@property(nonatomic, readonly) UITableView* tableView;

/**
* Activity name to use for showing detail of a grid data row.
*/
@property(nonatomic, readonly) NSString* activityName;


/**
* Initializes the renderer with data.
*/
- (id)initWithData:(expanz_model_AbstractData*)data tableView:(UITableView*)tableView
      activityName:(NSString*)activityName;

@end

/* ================================================================================================================== */
@compatibility_alias AbstractDataRenderer expanz_ui_AbstractDataRenderer;