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

@interface expanz_model_ActivityDefinition : NSObject

@property(nonatomic, strong, readonly) NSString* activityId;
@property(nonatomic, strong, readonly) NSString* title;
@property(nonatomic, strong, readonly) ActivityStyle* style;

- (id) initWithActivityId:(NSString*)name title:(NSString*)title style:(ActivityStyle*)style;

@end

/* ================================================================================================================== */
@compatibility_alias ActivityDefinition expanz_model_ActivityDefinition;
