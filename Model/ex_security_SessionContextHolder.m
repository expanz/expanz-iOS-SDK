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

#import "ex_security_SessionContextHolder.h"

@implementation ex_security_SessionContextHolder

@synthesize sessionKey = _sessionKey;

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
    }
    return self; 
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {    
    [_sessionKey release];
    [super dealloc];
}




@end
