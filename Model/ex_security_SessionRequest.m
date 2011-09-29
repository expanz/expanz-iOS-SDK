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

@implementation ex_security_SessionRequest


@synthesize userName = _userName;
@synthesize password = _password; 
@synthesize appSite = _appSite;



/* ================================================== Constructors ================================================== */

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


/* ================================================ Interface Methods =============================================== */

- (NSString*) toXml {
    return nil;
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_userName release];
    [_password release]; 
    [_appSite release];
    [super dealloc];
}

@end
