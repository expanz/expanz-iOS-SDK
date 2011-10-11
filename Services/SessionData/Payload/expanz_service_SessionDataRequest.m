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
#import "expanz_iOS_SDKExceptions.h"



@implementation expanz_service_SessionDataRequest

@synthesize sessionToken = _sessionToken;

/* ================================================== Constructors ================================================== */

- (id)initWithSessionToken:(NSString*)sessionToken {
    self = [self init];
    if (!self) {
        [NSException raise:ExObjectInitializationException format:@"Call to super-class initialization failed."];
    }
    _sessionToken = [sessionToken retain];
    return self;
}

/* ================================================= Protocol Methods =============================================== */
#pragma mark xml_Serializable

#define kXmlTemplate @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><GetSessionData/></ESA>\
</xml><sessionHandle>%@</sessionHandle></ExecX>"

- (NSString*) toXml {
    return [NSString stringWithFormat:kXmlTemplate, _sessionToken];
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_sessionToken release];
    [super dealloc];
    
}

@end
