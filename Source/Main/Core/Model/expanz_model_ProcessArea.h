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

@class expanz_model_ActivityMenuItem;

@interface expanz_model_ProcessArea : NSObject
{

@private
    NSMutableSet* _activities;
}

@property(nonatomic, strong, readonly) NSString* processId;
@property(nonatomic, strong, readonly) NSString* title;
@property(nonatomic, strong, readonly) NSArray* activities;

/**
* Initializes with the supplied processId and title parameters.
*/
- (id) initWithProcessId:(NSString*)processId andTitle:(NSString*)title;

/** 
* Adds an activity to the process area.
*/
- (void) addActivityDefinition:(expanz_model_ActivityMenuItem*)activity;

/**
 * Returns the activity with the supplied id, or nil if none matching. 
 */
- (expanz_model_ActivityMenuItem*) activityWithName:(NSString*)activityName;


@end

/* ================================================================================================================== */
@compatibility_alias ProcessArea expanz_model_ProcessArea;
