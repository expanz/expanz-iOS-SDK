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


#import "expanz_model_SessionContextHolder.h"
#import "expanz_iOS_SDKExceptions.h"
#import "RXMLElement.h"

static SessionContextHolder* globalContext;

@implementation expanz_model_SessionContextHolder

@synthesize sessionToken = _sessionToken;
@synthesize hasError = _hasError; 
@synthesize hasWarning = _hasWarning; 
@synthesize message = _message;

/* ================================================== Constructors ================================================== */

- (id) initWithSessionToken:(NSString*)sessionToken hasError:(BOOL)hasError hasWarning:(BOOL)hasWarning
                    message:(NSString*)message {
    
    self = [super init]; 
    if(self) {
        _sessionToken = [sessionToken retain];
        _hasError = hasError; 
        _hasWarning = hasWarning; 
        _message = [message retain];
    }
    return self; 
}



/* ================================================ Interface Methods =============================================== */

+ (void)setGlobalContext:(SessionContextHolder*)context {
    if (globalContext != context) {
        [globalContext release];
        globalContext = [context retain];
    }
}

+ (SessionContextHolder*) globalContext {  
    return [[globalContext retain] autorelease];
}




/* ================================================== Utility Methods =============================================== */

- (void) dealloc {    
    [_sessionToken release]; 
    [_message release];
    [super dealloc];
}




@end
