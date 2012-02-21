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
#import "expanz_model_AbstractData+DataRenderer.h"
#import "expanz_ui_AbstractDataRenderer.h"
#import "expanz_ui_GridDataRenderer.h"
#import "expanz_ui_TreeDataRenderer.h"
#import "expanz_model_GridData.h"
#import "expanz_model_TreeData.h"


/* ================================================================================================================== */
@implementation expanz_model_AbstractData (DataRenderer)

- (expanz_ui_AbstractDataRenderer*) withDataRendererFor:(UITableView*)tableView activityName:(NSString*)activityName {
    [NSException
        raise:NSInternalInconsistencyException format:@"Can't return data renderer for AbstractDataRenderer class"];
    return nil;
}

@end
/* ================================================================================================================== */

/* ================================================================================================================== */
@implementation expanz_model_GridData (DataRenderer)

- (expanz_ui_AbstractDataRenderer*) withDataRendererFor:(UITableView*)tableView activityName:(NSString*)activityName {
    LogDebug(@"Building grid data renderer.");
    return [[GridDataRenderer alloc] initWithData:self tableView:tableView activityName:activityName];
}

@end
/* ================================================================================================================== */


/* ================================================================================================================== */
@implementation expanz_model_TreeData (DataRenderer)

- (expanz_ui_AbstractDataRenderer*) withDataRendererFor:(UITableView*)tableView activityName:(NSString*)activityName {
    LogDebug(@"Building tree data renderer.");
    return [[TreeDataRenderer alloc] initWithData:self tableView:tableView activityName:activityName];
}

@end
/* ================================================================================================================== */
