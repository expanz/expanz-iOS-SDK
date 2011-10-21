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

@interface expanz_model_Field : NSObject

@property (nonatomic, readonly) NSString* fieldId; 
@property (nonatomic, readonly, getter = isNullable) BOOL nullable; 
@property (nonatomic, readonly) NSString* defaultValue; 
@property (nonatomic, readonly) NSString* datatype;
@property (nonatomic, readonly, getter = isDirty) BOOL dirty; 

@property (nonatomic, readwrite, assign) expanz_model_ActivityInstance* parentActivity;
@property (nonatomic, readwrite, retain) NSString* value;

- (id) initWithFieldId:(NSString*)fieldId nullable:(BOOL)nullable defaultValue:(NSString*)defaultValue 
              dataType:(NSString*)datatype; 

/**
 * Invoked when value is changed as a result of user edit. Marks the field as dirty. 
 */
- (void) userDidEditWithValue:(NSString*)value; 

/**
 * Invoked to indicate the server state has been synchronized with the client-side state. Marks the field as clean.
 */
- (void) completedStateChangeWithValidation:(NSString*)validatedValue; 


@end

/* ================================================================================================================== */
@compatibility_alias Field expanz_model_Field;
