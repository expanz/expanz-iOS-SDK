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
@class expanz_model_Field;
@class expanz_model_Message;
@class expanz_model_AbstractData;
@class expanz_model_GridData;
@class expanz_model_FileResource;

/**
 * Represents an activity in progress. 
 */
@interface expanz_model_ActivityInstance : NSObject {

@private
    NSMutableSet* _fields;
    NSMutableSet* _fileResources;
    NSMutableArray* _messages;
    NSMutableArray* _dataSets;
}

@property(nonatomic, readonly) NSString* title;
@property(nonatomic, readonly) NSString* handle;
@property(nonatomic, readonly) NSString* persistentId;
@property(nonatomic, readonly) NSArray* fields;
@property(nonatomic, readonly) NSArray* fileResources;
@property(nonatomic, readonly) NSArray* messages;
@property(nonatomic, readonly) NSArray* dataSets;

/**
* Initializes new instance  with the supplied parameters.
*/
- (id) initWithTitle:(NSString*)title handle:(NSString*)handle persistentId:(NSString*)persistentId;

/** 
 * Adds a field to the instance. 
 */
- (void) addField:(expanz_model_Field*)field;

/**
* Returns the `expanz_model_Field` matching the supplied fieldId, or nil.
*/
- (expanz_model_Field*) fieldWithId:(NSString*)fieldId;

- (void) addFileResource:(expanz_model_FileResource*)fileResource;

/** 
* Adds a message to the instance.
*/
- (void) addMessage:(expanz_model_Message*)message;

/**
* Adds a data set to the instance.
*/
- (void) addData:(expanz_model_AbstractData*)data;

/**
* Returns the `expanz_model_DataSet` with the given id, or nil.
*/
- (expanz_model_AbstractData*) dataWithId:(NSString*)dataSetId;

/**
 * Indicates weather the activity in progress currently allows method invocations. For this to occur the client model
 * and server model must be syncrhonized - any field edits and value changes must be registered with the server.
 */
- (BOOL) allowsMethodInvocations;


@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstance expanz_model_ActivityInstance;
