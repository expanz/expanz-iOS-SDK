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
#import "expanz_model_AbstractData.h"
@class expanz_ui_AbstractDataRenderer;


@interface expanz_model_AbstractData (DataRenderer)

- (expanz_ui_AbstractDataRenderer*)withDataRendererFor:(UITableView*)tableView activityName:(NSString*)activityName;

@end