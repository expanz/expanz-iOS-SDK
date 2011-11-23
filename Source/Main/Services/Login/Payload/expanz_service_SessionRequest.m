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

@implementation expanz_service_SessionRequest

@synthesize userName = _userName;
@synthesize password = _password;
@synthesize appSite = _appSite;
@synthesize userType = _userType;


/* ================================================== Constructors ================================================== */
- (id)initWithUserName:(NSString*)userName password:(NSString*)password appSite:(NSString*)appSite
              userType:(NSString*)userType {

    self = [self init];
    if (self) {
        _userName = [userName copy];
        _password = [password copy];
        _appSite = [appSite copy];
        _userType = [userType copy];
    }
    return self;
}



/* ================================================= Protocol Methods =============================================== */
#pragma mark xml_Serializable

#define kXmlTemplate @"<CreateSessionX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA>\
<CreateSession user=\"%@\" password=\"%@\" appSite=\"%@\" authenticationMode=\"%@\" clientVersion=\"%@\" \
schemaVersion=\"%@\"/></ESA></xml></CreateSessionX>"

- (NSString*)toXml {
    return [NSString stringWithFormat:kXmlTemplate, _userName, _password, _appSite, _userType, kClientVersion,
                                      kSchemaVersion];
}


/* ================================================== Utility Methods =============================================== */

- (void)dealloc {
    [_userName release];
    [_password release];
    [_appSite release];
    [_userType release];
    [super dealloc];
}


@end
