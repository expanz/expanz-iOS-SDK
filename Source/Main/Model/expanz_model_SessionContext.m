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


#import "expanz_model_SessionContext.h"

static SessionContext* globalContext;

@implementation expanz_model_SessionContext

@synthesize sessionToken = _sessionToken;
@synthesize hasError = _hasError;
@synthesize hasWarning = _hasWarning;
@synthesize message = _message;


/* ================================================= Class Methods ================================================== */
+ (void) setGlobalContext:(SessionContext*)context {
    if (globalContext != context) {
        [globalContext release];
        globalContext = [context retain];
    }
}

+ (SessionContext*) globalContext {
    return [[globalContext retain] autorelease];
}


/* ================================================== Initializers ================================================== */
- (id) initWithSessionToken:(NSString*)sessionToken hasError:(BOOL)hasError hasWarning:(BOOL)hasWarning
                    message:(NSString*)message {

    self = [super init];
    if (self) {
        _sessionToken = [sessionToken retain];
        _hasError = hasError;
        _hasWarning = hasWarning;
        _message = [message retain];
    }
    return self;
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_sessionToken release];
    [_message release];
    [super dealloc];
}


@end
