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
#import "xml_Serializable.h"

@class expanz_model_Field;

@interface expanz_service_DeltaRequest : NSObject<xml_Serializable>

@property (nonatomic, readonly) NSString* fieldId;
@property (nonatomic, readonly) NSString* fieldValue;
@property (nonatomic, readonly) NSString* sessionToken;
@property (nonatomic, readonly) NSString* activityHandle;

/**
 * Creates an auto-released instance from using field data.
 */
+ (id) fromField:(expanz_model_Field*)field;

/**
 * Initializes an instance with the supplied parameters.
 */
- (id) initWithFieldId:(NSString*)fieldId fieldValue:(NSString*)fieldValue activityHandle:(NSString*)activityHandle
          sessionToken:(NSString*)sessionToken;

@end

/* ================================================================================================================== */
@compatibility_alias DeltaRequest expanz_service_DeltaRequest;
