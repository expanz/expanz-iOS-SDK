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
#import "expanz_model_ActivityStyle.h"

@class expanz_ui_ActivityInstanceViewController;
@class expanz_model_ActivityInstance;


@interface expanz_ui_ActivityControllerBuilder : NSObject {

    NSString* _activityId;
}

@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) ActivityStyle* activityStyle;
@property(nonatomic, strong) NSString* initialKey;
@property(nonatomic) BOOL shouldAttachToServer;
@property(nonatomic, strong) expanz_model_ActivityInstance* activityInstance;

+ (expanz_ui_ActivityControllerBuilder*) forActivityId:(NSString*)activityId;

- (expanz_ui_ActivityInstanceViewController*) build;


@end
/* ================================================================================================================== */
@compatibility_alias ActivityControllerBuilder expanz_ui_ActivityControllerBuilder;