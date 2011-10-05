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

#import "JBPackageVoodoo.h"

/* ================================================================================================================== */

@interface expanz_service_SessionRequest(private)

- (void) setUserName:(NSString*)userName;
- (void) setPassword:(NSString*)password;
- (void) setAppsite:(NSString*)appSite;

@end

/* ================================================================================================================== */

@implementation expanz_service_SessionRequest

@synthesize userName = _userName;
@synthesize password = _password; 
@synthesize appSite = _appSite;


/* ================================================== Constructors ================================================== */

- (id) init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }    
    return self;
}

- (id) initWithUserName:(NSString*)userName password:(NSString*)password appSite:(NSString*)appSite {
    self = [self init];   
    [self setUserName:userName];
    [self setPassword:password];
    [self setAppsite:appSite];    
    return self; 
}


/* ================================================ Delegate Methods ================================================ */
#pragma mark jb_xml_Serializable

#define kSessionRequestXml @"<CreateSessionX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA>\
<CreateSession user=\"%@\" password=\"%@\" appSite=\"%@\" authenticationMode=\"%@\" clientVersion=\"%@\" \
schemaVersion=\"%@\"/></ESA></xml></CreateSessionX>"

- (NSString*) toXml {
    return [NSString stringWithFormat:kSessionRequestXml, _userName, _password, _appSite, kAuthenticationMode, 
            kClientVersion, kSchemaVersion];
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_userName release];
    [_password release]; 
    [_appSite release];
    [super dealloc];
}

/* ================================================== Private Methods =============================================== */

- (void) setUserName:(NSString*)userName {
    _userName = userName;
    [userName retain];    
}

- (void) setPassword:(NSString*)password {
    _password = password;
    [password retain];
}

- (void) setAppsite:(NSString*)appSite {
    _appSite = appSite;
    [appSite retain];
}



@end
