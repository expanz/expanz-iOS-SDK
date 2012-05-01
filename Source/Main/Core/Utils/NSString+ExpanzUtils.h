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

@class expanz_model_ActivityStyle;

@interface NSString (ExpanzUtils)

+ (NSString*) controllerClassNameForActivityId:(NSString*)activityId style:(expanz_model_ActivityStyle*)style;

+ (NSString*) nibNameForActivityId:(NSString*)activityId style:(expanz_model_ActivityStyle*)style;

@end