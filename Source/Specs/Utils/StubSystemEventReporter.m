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
#import "StubSystemEventReporter.h"


@implementation StubSystemEventReporter

@synthesize message = _message;

/* ================================================= Protocol Methods =============================================== */
- (void)reportErrorWithReason:(NSString*)reason {
    LogDebug(@"Error with reason: %@", reason);
    _message = [reason copy];
}

- (void)reportWarningWithReason:(NSString*)reason {
    LogDebug(@"Warning with reason: %@", reason);
    _message = [reason copy];
}

- (void)reportMessageWithTitle:(NSString*)title message:(NSString*)message {
    LogDebug(@"Message with title: %@, message: %@", title, message);
    _message = [message copy];
}


/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [_message release];
    [super dealloc];
}

@end

