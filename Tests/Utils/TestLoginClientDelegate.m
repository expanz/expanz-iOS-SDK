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

#import "TestLoginClientDelegate.h"

@implementation TestLoginClientDelegate

@synthesize sessionContext = _sessionContext, error = _error;

- (void) requestDidFinishWithSessionContext:(SessionContext*)sessionContext {
    self.sessionContext = sessionContext;    
}

- (void) requestDidFailWithError:(NSError*)error {
    self.error = error;     
}

- (void) dealloc {
    [_sessionContext release];
    [_error release];
    [super dealloc];    
}

@end
