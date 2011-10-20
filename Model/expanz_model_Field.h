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
@property (nonatomic, readonly) BOOL dirty; 

@property (nonatomic, readonly, getter = isNullable) BOOL nullable; 
@property (nonatomic, readonly) NSString* defaultValue; 
@property (nonatomic, readonly) NSString* datatype; 

@property (nonatomic, readwrite, assign) expanz_model_ActivityInstance* parentActivity;
@property (nonatomic, readwrite, retain) NSString* value;

- (id) initWithFieldId:(NSString*)fieldId nullable:(BOOL)nullable defaultValue:(NSString*)defaultValue 
              dataType:(NSString*)datatype; 


@end

/* ================================================================================================================== */
@compatibility_alias Field expanz_model_Field;
