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
    LogDebug(@"The global context is now: %@", context);
    globalContext = context;
}

+ (SessionContext*) globalContext {
    return globalContext;
}


/* ================================================== Initializers ================================================== */
- (id) initWithSessionToken:(NSString*)sessionToken hasError:(BOOL)hasError hasWarning:(BOOL)hasWarning
                    message:(NSString*)message {

    self = [super init];
    if (self) {
        _sessionToken = [sessionToken copy];
        _hasError = hasError;
        _hasWarning = hasWarning;
        _message = [message copy];
    }
    return self;
}

@end
