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
#import "NSString+ExpanzDataType.h"

@class expanz_model_ActivityInstance;

/**
 * Represents an item within an `expanz_model_ActivityInstance` requiring user input. 
 */
@interface expanz_model_Field : NSObject


/* ================================================================================================================== */

/** Unique identifier. */
@property(nonatomic, strong, readonly) NSString* fieldId;

/** Indicates if the field is mandatory. */
@property(nonatomic, readonly, getter = isNullable) BOOL nullable;

/** The value the field is initialized with, ie user is presented initially with this value. */
@property(nonatomic, strong, readonly) NSString* defaultValue;

/** The field's datatype. */
@property(nonatomic, readonly) ExpanzDataType datatype;

/** Indicates the client model is not yet synchronized with the server model. */
@property(nonatomic, readonly, getter = isDirty) BOOL dirty;

/** Label to display next to the field */
@property(nonatomic, strong, readonly) NSString* label;

/** Additional user instructions for the field. */
@property(nonatomic, strong, readonly) NSString* hint;

/** Reference to the activity this field belongs to. */
@property(nonatomic, readwrite, assign) expanz_model_ActivityInstance* parentActivity;

/** The value held by this field. */
@property(nonatomic, readwrite, retain) NSString* value;

/** Weather the field allows user input */
@property(nonatomic, readwrite, getter = isDisabled) BOOL disabled;


/* ================================================================================================================== */

- (id) initWithFieldId:(NSString*)fieldId nullable:(BOOL)nullable defaultValue:(NSString*)defaultValue
              dataType:(ExpanzDataType)datatype label:(NSString*)label hint:(NSString*)hint;

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
