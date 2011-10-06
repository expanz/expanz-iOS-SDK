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


#import "JBPackageVoodoo.h"
#import "RXMLElement.h"

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

- (id) initWithXml:(NSString*)xml {
    self = [self init]; 
    if (!self) {
        [NSException raise:kInitializationFailed format:@"Call to superclass initializer failed."];
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
            [NSException raise:kXmlValidationFailed format:@"Contains neither a session token or an error message."];
        }
    }        
    return self; 
}




/* ================================================== Utility Methods =============================================== */

- (void) dealloc {    
    [_sessionToken release];
    [_errorMessage release];
    [_warningMessage release];
    [super dealloc];
}




@end
