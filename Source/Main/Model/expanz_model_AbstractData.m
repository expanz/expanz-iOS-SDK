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
#import "expanz_model_AbstractData.h"
#import "expanz_ui_AbstractDataRenderer.h"


@implementation expanz_model_AbstractData

@synthesize dataId = _dataId;

/* ================================================== Initializers ================================================== */

- (id)initWithDataId:(NSString*)dataId {
    self = [super init];
    if (self) {
        _dataId = [dataId copy];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (expanz_ui_AbstractDataRenderer*)withDataRendererFor:(UITableView*)tableView activityName:(NSString*)activityName {
    @throw ([NSException
        exceptionWithName:NSInternalInconsistencyException reason:@"This class should not be instantiated directly."
                 userInfo:nil]);
}


@end