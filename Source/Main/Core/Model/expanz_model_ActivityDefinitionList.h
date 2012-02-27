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
#import "expanz_model_ActivityDefinition.h"

@interface expanz_model_ActivityDefinitionList : NSObject {

@private
    NSMutableArray* _activities;
}

@property(nonatomic, strong, readonly) NSArray* activities;

- (void) addActivityDefinition:(expanz_model_ActivityDefinition*)activityDefinition;

@end
/* ================================================================================================================== */
@compatibility_alias ActivityDefinitionList expanz_model_ActivityDefinitionList;