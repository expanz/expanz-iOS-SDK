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

#import "StubActivityClientDelegate.h"
#import "expanz_model_ActivityInstance.h"

@implementation StubActivityClientDelegate

@synthesize activityInstance = _activityInstance, error = _error;

- (void) requestDidFinishWithActivityInstance:(ActivityInstance*)activityInstance {
    LogDebug(@"Got activity instance: %@", activityInstance);
    _activityInstance = [activityInstance retain]; 
}

- (void) requestDidFailWithError:(NSError*)error {
    _error = [error retain];
}

- (void) dealloc {
    [_activityInstance release]; 
    [_error release]; 
    [super dealloc]; 
}

@end