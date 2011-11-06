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

@class expanz_model_ActivityDefinition;

/**
* Responsible for initiating server-side activities and transferring to the activity view.
*/
@interface expanz_ui_ActivityManager : NSObject

+ (BOOL) transitionToActivityWithDefinition:(expanz_model_ActivityDefinition*)activityDefinition;


@end

/* ================================================================================================================== */
@compatibility_alias ActivityManager expanz_ui_ActivityManager;