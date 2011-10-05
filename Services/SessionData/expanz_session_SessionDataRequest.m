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

#import "expanz_session_SessionDataRequest.h"

#define kSessionDataRequestXml @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><GetSessionData/></ESA>\
</xml><sessionHandle>%@</sessionHandle></ExecX>"

@implementation expanz_session_SessionDataRequest

@synthesize sessionToken = _sessionToken;

/* ================================================== Constructors ================================================== */
- (id)initWithSessionToken:(NSString*)sessionToken {
    self = [super init];
    if (self) {
        _sessionToken = sessionToken; 
        [_sessionToken retain];
    }    
    return self;
}

/* ================================================ Delegate Methods ================================================ */
#pragma mark jb_xml_Serializable

- (NSString*) toXml {
    return nil;
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    
    [super dealloc];
    
}

@end
