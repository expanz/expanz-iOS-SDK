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


@interface expanz_model_MethodSchema : NSObject

@property(nonatomic, strong, readonly) NSString* name;
@property(nonatomic, strong, readonly) NSString* description;

- (id) initWithName:(NSString*)name description:(NSString*)description;


@end
/* ================================================================================================================== */
@compatibility_alias MethodSchema expanz_model_MethodSchema;