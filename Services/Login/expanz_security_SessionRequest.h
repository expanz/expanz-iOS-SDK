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
#import "JBPackageVoodoo.h"
#import "jb_xml_Serializable.h"

@interface expanz_security_SessionRequest : NSObject<jb_xml_Serializable>

#define kAuthenticationMode @"Primary" 
#define kClientVersion @"iOS 1.0"
#define kSchemaVersion @"2.0"

#define kSessionRequestXml @"<CreateSessionX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA>\
<CreateSession user=\"%@\" password=\"%@\" appSite=\"%@\" authenticationMode=\"%@\" clientVersion=\"%@\" \
schemaVersion=\"%@\"/></ESA></xml></CreateSessionX>"


@property (nonatomic, retain) NSString* userName; 
@property (nonatomic, retain) NSString* password;
@property (nonatomic, retain) NSString* appSite;

- (id) initWithUserName:(NSString*)userName password:(NSString*)password appSite:(NSString*)appSite;

@end
