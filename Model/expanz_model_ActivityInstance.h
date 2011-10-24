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

#import "expanz_model_Activity.h"
@class expanz_model_Field;
@class expanz_model_Message;

/**
 * Represents an activity in progress. 
 */
@interface expanz_model_ActivityInstance : expanz_model_Activity {
    
@private
    NSMutableSet* _fields;         
    NSMutableArray* _messages;
}


@property (nonatomic, readonly) NSString* handle; 
@property (nonatomic, readonly) NSString* persistentId;
@property (nonatomic, readonly) NSArray* fields; 
@property (nonatomic, readonly) NSArray* messages; 

/**
 * Initializes new instance with the supplied parameters. 
 */
- (id) initWithTitle:(NSString*)title handle:(NSString*)handle persistentId:(NSString*)persistentId;

/** 
 * Adds a field to the instance. 
 */
- (void) addField:(expanz_model_Field*)field; 

/** 
 * Adds a message to the instance. 
 */
- (void) addMessage:(expanz_model_Message*)message; 

/**
 * Returns the field matching the supplied fieldId, or nil. 
 */
- (expanz_model_Field*) fieldWithId:(NSString*)fieldId;

/**
 * Indicates weather the activity in progress currently allows method invocations. For this to occur the client model
 * and server model must be syncrhonized - any field edits and value changes must be registered with the server.
 */
- (BOOL) allowsMethodInvocations; 


@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstance expanz_model_ActivityInstance;
