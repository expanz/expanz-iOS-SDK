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

@interface expanz_model_Field : NSObject

@property (nonatomic, readonly) NSString* fieldId; 
@property (nonatomic, readonly, getter = isNullable) BOOL nullable; 
@property (nonatomic, readonly) NSString* defaultValue; 
@property (nonatomic, readonly) NSString* datatype; 

- (id) initWithFieldId:(NSString*)fieldId nullable:(BOOL)nullable defaultValue:(NSString*)defaultValue 
              dataType:(NSString*)datatype; 


@end

/* ================================================================================================================== */
@compatibility_alias Field expanz_model_Field;
