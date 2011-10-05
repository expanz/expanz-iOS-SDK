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

@implementation expanz_security_SessionRequest

@synthesize userName = _userName;
@synthesize password = _password; 
@synthesize appSite = _appSite;


/* ================================================== Constructors ================================================== */

- (id) init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }    
    return self;
}

- (id) initWithUserName:(NSString*)userName password:(NSString*)password appSite:(NSString*)appSite {
    self = [self init];
    if (self) {
        self.userName = userName; 
        self.password = password; 
        self.appSite = appSite;
    }
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

@end
