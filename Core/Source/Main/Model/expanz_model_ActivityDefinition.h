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
#import "ExpanzActivityStyle.h"

@interface expanz_model_ActivityDefinition : NSObject

@property(nonatomic, readonly) NSString* name;
@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) ExpanzActivityStyle style;

- (id) initWithName:(NSString*)name title:(NSString*)title style:(ExpanzActivityStyle)style;

@end

/* ================================================================================================================== */
@compatibility_alias ActivityDefinition expanz_model_ActivityDefinition;
