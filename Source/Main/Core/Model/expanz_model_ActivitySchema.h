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

@class expanz_model_FieldInstance;
@class expanz_model_MethodSchema;
@class expanz_model_FieldSchema;


@interface expanz_model_ActivitySchema : NSObject {

@private
    NSMutableArray* _fields;
    NSMutableArray* _methods;
    NSMutableArray* _styles;
    NSMutableArray* _queries;
}

@property(nonatomic, strong, readonly) NSString* activityId;
@property(nonatomic, strong, readonly) NSString* title;
@property(nonatomic, strong, readonly) NSArray* fields;
@property(nonatomic, strong, readonly) NSArray* methods;
@property(nonatomic, strong, readonly) NSArray* styles;
@property(nonatomic, strong, readonly) NSArray* queries;

- (id) initWithActivityId:(NSString*)activity title:(NSString*)title;

- (NSString*) viewControllerName;

- (void) addField:(expanz_model_FieldSchema*)field;

- (void) addMethod:(expanz_model_MethodSchema*)method;



@end
/* ================================================================================================================== */
@compatibility_alias ActivitySchema expanz_model_ActivitySchema;