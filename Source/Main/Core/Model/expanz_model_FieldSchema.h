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


@interface expanz_model_FieldSchema : NSObject

@property(nonatomic, strong, readonly) NSString* name;
@property(nonatomic, strong, readonly) NSString* class;
@property(nonatomic, strong, readonly) NSString* label;

- (id) initWithName:(NSString*)name class:(NSString*)class label:(NSString*)label;


@end
/* ================================================================================================================== */
@compatibility_alias FieldSchema expanz_model_FieldSchema;