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
#import <Objection-iOS/Objection.h>
#import "expanz_ui_SystemEventPresenter.h"

@class expanz_model_ActivityDefinition;

/**
* Responsible for initiating server-side activities and transferring to the activity view.
*/
@interface expanz_ui_ActivityManager : NSObject

@property (nonatomic, retain) id<expanz_ui_SystemEventPresenter> reporter;

- (BOOL) transitionToActivityWithDefinition:(expanz_model_ActivityDefinition*)activityDefinition;

- (BOOL) transitionToActivityWithDefinition:(expanz_model_ActivityDefinition*)activityDefinition
                                 initialKey:(NSString*)initialKey;

@end

/* ================================================================================================================== */
@compatibility_alias ActivityManager expanz_ui_ActivityManager;