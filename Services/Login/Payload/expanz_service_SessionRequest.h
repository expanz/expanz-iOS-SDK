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

@interface expanz_service_SessionRequest : NSObject<xml_Serializable>

#define kAuthenticationMode @"Primary" 
#define kClientVersion @"iOS 1.0"
#define kSchemaVersion @"2.0"

@property (nonatomic, readonly) NSString* userName; 
@property (nonatomic, readonly) NSString* password;
@property (nonatomic, readonly) NSString* appSite;

/**
 * Initializes an instance using the supplied session token. 
 */
- (id) initWithUserName:(NSString*)userName password:(NSString*)password appSite:(NSString*)appSite;

@end

/* ================================================================================================================== */
@compatibility_alias SessionRequest expanz_service_SessionRequest;

