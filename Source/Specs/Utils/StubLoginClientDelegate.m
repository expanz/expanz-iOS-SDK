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

#import "StubLoginClientDelegate.h"
#import "expanz_model_SessionContext.h"

@implementation StubLoginClientDelegate

@synthesize sessionContext = _sessionContext, error = _error;

- (void) requestDidFinishWithSessionContext:(SessionContext*)sessionContext {
    self.sessionContext = sessionContext;    
}

- (void) requestDidFailWithError:(NSError*)error {
    self.error = error;     
}

@end
