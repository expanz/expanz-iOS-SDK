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

@implementation expanz_security_SessionContextHolder

@synthesize sessionToken = _sessionToken;
@synthesize hasError = _hasError; 
@synthesize errorMessage = _errorMessage;
@synthesize hasWarning = _hasWarning; 
@synthesize warningMessage = _warningMessage;

/* ================================================== Constructors ================================================== */

/**
 * Create an autoreleased instance from XML. 
 */
+ (id) fromXml:(NSString*)xml {
    return [[[self alloc] initWithXml:xml] autorelease];
}

- (id) init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

/**
 * Create an instance with XML. 
 */
- (id) initWithXml:(NSString*)xml {
    self = [self init]; 
    if (self) {
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
        }        
    }
    return self; 
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {    
    [_sessionToken release];
    [super dealloc];
}




@end
