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

@interface expanz_service_SessionRequest : NSObject <xml_Serializable>

#define kClientVersion @"iOS 1.0"
#define kSchemaVersion @"2.0"

@property(nonatomic, strong, readonly) NSString* userName;
@property(nonatomic, strong, readonly) NSString* password;
@property(nonatomic, strong, readonly) NSString* appSite;
@property(nonatomic, strong, readonly) NSString* userType;


/**
* Initializes an instance using the supplied userName, password, appSite and user type.
*/
- (id)initWithUserName:(NSString*)userName password:(NSString*)password appSite:(NSString*)appSite
              userType:(NSString*)userType;

@end

/* ================================================================================================================== */
@compatibility_alias SessionRequest expanz_service_SessionRequest;

