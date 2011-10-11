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

- (id) initWithActivityName:(NSString*)activityName andSessionToken:(NSString*)sessionToken {
    self = [self init];
    _activityName = [activityName retain];
    _sessionToken = [sessionToken retain];
    return self;
}

/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_activityName release];
    [_sessionToken release];
    [super dealloc];
}

@end
