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


typedef enum {
    DeltaEncodingDefault, DeltaEncodingBase64
}  DeltaEncoding;


@class expanz_model_FieldInstance;

@interface expanz_service_DeltaRequest : NSObject<xml_Serializable>

@property (nonatomic, strong, readonly) NSString* fieldId;
@property (nonatomic, strong, readonly) NSString* fieldValue;
@property (nonatomic, strong, readonly) NSString* sessionToken;
@property (nonatomic, strong, readonly) NSString* activityHandle;
@property (nonatomic, readonly) DeltaEncoding encoding;

/**
 * Creates an auto-released instance from using field data.
 */
+ (id) forField:(expanz_model_FieldInstance*)field;


/**
 * Initializes an instance with the supplied parameters, using the default encoding.
 */
- (id) initWithFieldId:(NSString*)fieldId fieldValue:(NSString*)fieldValue activityHandle:(NSString*)activityHandle
          sessionToken:(NSString*)sessionToken;

/**
* Initializes an instance with the supplied parameters.
*/
- (id) initWithFieldId:(NSString*)fieldId fieldValue:(NSString*)fieldValue activityHandle:(NSString*)activityHandle
          sessionToken:(NSString*)sessionToken encoding:(DeltaEncoding)encoding;



@end

/* ================================================================================================================== */
@compatibility_alias DeltaRequest expanz_service_DeltaRequest;
