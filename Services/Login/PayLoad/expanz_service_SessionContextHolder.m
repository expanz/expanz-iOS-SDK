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


#import "expanz_service_SessionContextHolder.h"
#import "expanz_iOS_SDKExceptions.h"
#import "RXMLElement.h"

static SessionContextHolder* globalContext;

@implementation expanz_service_SessionContextHolder

@synthesize sessionToken = _sessionToken;
@synthesize hasError = _hasError; 
@synthesize errorMessage = _errorMessage;
@synthesize hasWarning = _hasWarning; 
@synthesize warningMessage = _warningMessage;

/* ================================================== Constructors ================================================== */

+ (id) fromXml:(NSString*)xml {
    return [[[self alloc] initWithXml:xml] autorelease];
}

//TODO: Replace this with a vanila initializer. Use a RXMLElement category to parse.
- (id) initWithXml:(NSString*)xml {
    self = [self init]; 
    if (!self) {
        [NSException raise:ExObjectInitializationException format:@"Call to superclass initializer failed."];
    }
    LogDebug(@"Initializing SessionContextHolder with xml: %@", xml);
    RXMLElement* rootElement = [RXMLElement elementFromXMLString:xml];
    RXMLElement* sessionToken = [rootElement child:@"CreateSessionXResult"];
    RXMLElement* error = [rootElement child:@"errorMessage"];

    if (sessionToken.text.length > 0) {
        self.sessionToken = sessionToken.text;
        if (error != nil) {
            self.hasWarning = YES; 
            self.warningMessage = error.text; 
        }
    }
    else {            
        if (error != nil) {
            self.hasError = YES; 
            self.errorMessage = error.text;
        }
        else {
            [NSException raise:ExXmlValidationException format:@"Contains neither a session token or an error message."];
        }
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
    [_errorMessage release];
    [_warningMessage release];
    [super dealloc];
}




@end
