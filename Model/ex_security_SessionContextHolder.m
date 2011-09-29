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
//

#import "JBPackageVoodoo.h"
#import "RXMLElement.h"

@implementation ex_security_SessionContextHolder

@synthesize sessionToken = _sessionToken;

/* ================================================== Constructors ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (id) initWithXml:(id)xml {
    self = [self init]; 
    if (self) {
        LogDebug(@"Initializing SessionContextHolder with xml: %@", xml);
        RXMLElement* sessionContext = [RXMLElement elementFromXMLString:xml];
        RXMLElement* sessionToken = [sessionContext child:@"CreateSessionXResult"];
        if (sessionToken != nil) {
            self.sessionToken = [sessionToken text];
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
