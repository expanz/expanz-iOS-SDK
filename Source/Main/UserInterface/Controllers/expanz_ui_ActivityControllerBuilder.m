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

#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_ActivityControllerBuilder.h"
#import "expanz_ui_SystemEventReporter.h"
#import "Objection.h"
#import "NSString+ExpanzUtils.h"

@interface expanz_ui_ActivityControllerBuilder (Private)

- (id) initWithActivityId:(NSString*)activityId;

@end

@implementation expanz_ui_ActivityControllerBuilder

@synthesize title = _title;
@synthesize style = _style;
@synthesize initialKey = _initialKey;
@synthesize shouldAttachToServer = _shouldAttachToServer;

/* ================================================= Class Methods ================================================== */
+ (expanz_ui_ActivityControllerBuilder*) forActivityId:(NSString*)activityId {

    return [[ActivityControllerBuilder alloc] initWithActivityId:activityId];
}

/* ================================================== Initializers ================================================== */
- (id) initWithActivityId:(NSString*)activityId {
    self = [super init];
    if (self) {
        _activityId = activityId;
    }
    return self;
}

- (expanz_ui_ActivityInstanceViewController*) build {

    NSString* controllerClassName = [NSString controllerClassNameForActivityId:_activityId style:_style];
    id clazz = objc_getClass([controllerClassName cStringUsingEncoding:NSASCIIStringEncoding]);

    if (clazz) {
        ActivityInstanceViewController* controller = [clazz alloc];
        NSString* nibName = [NSString nibNameForActivityId:_activityId style:_style];
        [controller initWithActivityId:_activityId title:_title style:_style initialKey:_initialKey nibName:nibName];
        if (_shouldAttachToServer) {
            [controller attachToServerWithInitialKey:_initialKey];
        }
        return controller;
    }
    return nil;

}


@end