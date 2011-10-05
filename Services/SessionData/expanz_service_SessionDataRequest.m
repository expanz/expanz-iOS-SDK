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

#import "expanz_service_SessionDataRequest.h"



@implementation expanz_service_SessionDataRequest

@synthesize sessionToken = _sessionToken;

/* ================================================== Constructors ================================================== */

#pragma mark 'dedicated initializer' 
- (id) init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }    
    return self;
}

/**
 * Initializes an instance using the supplied session token. 
 */
- (id)initWithSessionToken:(NSString*)sessionToken {
    self = [self init];
    _sessionToken = sessionToken; 
    [_sessionToken retain];
    return self;
}

/* ================================================ Delegate Methods ================================================ */
#pragma mark jb_xml_Serializable

#define kSessionDataRequestXml @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><GetSessionData/></ESA>\
</xml><sessionHandle>%@</sessionHandle></ExecX>"

- (NSString*) toXml {
    return [NSString stringWithFormat:kSessionDataRequestXml, _sessionToken];
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_sessionToken release];
    [super dealloc];
    
}

@end
