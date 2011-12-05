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
#import "expanz_model_GridData.h"

@class expanz_ui_ActivityManager;
@class expanz_ui_components_ThumbnailTableCell;

@interface expanz_ui_GridDataRenderer : NSObject<UITableViewDataSource, UITableViewDelegate> {
    
@private 
    expanz_ui_ActivityManager* _activityManager; 
}

/**
* Data to be rendered. 
*/
@property (nonatomic, readonly) GridData* gridData;

/**
* UITableView to display the data. 
*/
@property (nonatomic, readonly) UITableView* tableView;

/**
* Activity name to use for showing detail of a grid data row. 
*/
@property (nonatomic, readonly) NSString* activityName; 

/**
* Injection point for loading custom table cells from a nib.
*/
@property (nonatomic, assign) IBOutlet expanz_ui_components_ThumbnailTableCell* tableCell;

/**
* Initializes the renderer with data. 
*/
- (id) initWithGridData:(GridData*)gridData tableView:(UITableView*)tableView activityName:(NSString*)activityName;



@end

/* ================================================================================================================== */
@compatibility_alias GridDataRenderer expanz_ui_GridDataRenderer;