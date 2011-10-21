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
@class expanz_model_ActivityInstance;

/**
 * Represents an item within an `expanz_model_ActivityInstance` requiring user input. 
 */
@interface expanz_model_Field : NSObject


/* ================================================================================================================== */

/** Unique identifier. */
@property (nonatomic, readonly) NSString* fieldId; 

/** Indicates if the field is mandatory. */
@property (nonatomic, readonly, getter = isNullable) BOOL nullable; 

/** The value the field is initialized with, ie user is presented initially with this value. */
@property (nonatomic, readonly) NSString* defaultValue; 

/** The field's datatype. TODO: This should not be represented by a string value. */
@property (nonatomic, readonly) NSString* datatype;

/** Indicates the client model is not yet synchronized with the server model. */
@property (nonatomic, readonly, getter = isDirty) BOOL dirty; 

/** Reference to the activity this field belongs to. */
@property (nonatomic, readwrite, assign) expanz_model_ActivityInstance* parentActivity;

/** The value held by this field. */
@property (nonatomic, readwrite, retain) NSString* value;


/* ================================================================================================================== */

- (id) initWithFieldId:(NSString*)fieldId nullable:(BOOL)nullable defaultValue:(NSString*)defaultValue 
              dataType:(NSString*)datatype; 

/**
 * Invoked when value is changed as a result of user edit. Marks the field as dirty. 
 */
- (void) didFinishEditWithValue:(NSString*)value; 

/**
 * Invoked to indicate the server state has been synchronized with the client-side state. Marks the field as clean.
 */
- (void) didSynchronizeStateWithServerModel:(NSString*)validatedValue; 


@end

/* ================================================================================================================== */
@compatibility_alias Field expanz_model_Field;
