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

#import "expanz_service_CreateActivityRequest.h"
#import "expanz_iOS_SDKExceptions.h"

@implementation expanz_service_CreateActivityRequest

@synthesize activityName = _activityName;
@synthesize sessionToken = _sessionToken;

/* ================================================== Constructors ================================================== */

- (id) init {
    self = [super init];    
    if (!self) {
        [NSException raise:ExObjectInitializationException format:@"Call to super-class initialization failed."];
    }
    return self;
}

- (id) initWithActivityName:(NSString*)activityName sessionToken:(NSString*)sessionToken {
    self = [self init];
    _activityName = [activityName retain];
    _sessionToken = [sessionToken retain];
    return self;
}

/* ================================================= Protocol Methods =============================================== */
#pragma mark xml_Serializable


#define kXmlTempate @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><CreateActivity name=\"%@\"/></ESA>\
</xml><sessionHandle>%@</sessionHandle></ExecX>"

- (NSString*) toXml {
    return [NSString stringWithFormat:kXmlTempate, _activityName, _sessionToken];
}

/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_activityName release];
    [_sessionToken release];
    [super dealloc];
}

@end
