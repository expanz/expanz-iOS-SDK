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
#import "expanz_model_ActivityMenuItem.h"

@interface expanz_model_ActivityMenu : NSObject {

@private
    NSMutableArray* _activities;
}

@property(nonatomic, strong, readonly) NSArray* activities;

- (void) addActivityDefinition:(expanz_model_ActivityMenuItem*)activityDefinition;

@end
/* ================================================================================================================== */
@compatibility_alias ActivityMenu expanz_model_ActivityMenu;