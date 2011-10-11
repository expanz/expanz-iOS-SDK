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

#import "expanz_service_SessionRequest.h"
#import "expanz_iOS_SDKExceptions.h"


@implementation expanz_service_SessionRequest

@synthesize userName = _userName;
@synthesize password = _password; 
@synthesize appSite = _appSite;


/* ================================================== Constructors ================================================== */


- (id) initWithUserName:(NSString*)userName password:(NSString*)password appSite:(NSString*)appSite {    
    self = [self init];   
    if (!self) {
        [NSException raise:ExObjectInitializationException format:@"Call to super-class initialization failed."];
    }
    _userName = [userName retain];
    _password = [password retain];
    _appSite = [appSite retain];
    return self; 
}


/* ================================================= Protocol Methods =============================================== */
#pragma mark xml_Serializable

#define kXmlTemplate @"<CreateSessionX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA>\
<CreateSession user=\"%@\" password=\"%@\" appSite=\"%@\" authenticationMode=\"%@\" clientVersion=\"%@\" \
schemaVersion=\"%@\"/></ESA></xml></CreateSessionX>"

- (NSString*) toXml {
    return [NSString stringWithFormat:kXmlTemplate, _userName, _password, _appSite, kAuthenticationMode, 
            kClientVersion, kSchemaVersion];
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_userName release];
    [_password release]; 
    [_appSite release];
    [super dealloc];
}


@end
