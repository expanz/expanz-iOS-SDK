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
#import "Objection.h"
#import "expanz_ui_AlertBoxSystemEventReporter.h"


@implementation expanz_ui_AlertBoxSystemEventReporter

objection_register_singleton(expanz_ui_AlertBoxSystemEventReporter)

@synthesize delegate = _delegate;

/* ================================================= Protocol Methods =============================================== */

- (void)reportErrorWithReason:(NSString*)reason {
    UIAlertView* alert = [[UIAlertView alloc]
        initWithTitle:@"Error" message:reason delegate:_delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

- (void)reportWarningWithReason:(NSString*)reason {
    UIAlertView* alert = [[UIAlertView alloc]
        initWithTitle:@"Warning" message:reason delegate:_delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];

}

- (void)reportMessageWithTitle:(NSString*)title message:(NSString*)message {
    UIAlertView* alert = [[UIAlertView alloc]
        initWithTitle:title message:message delegate:_delegate cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
    [alert release];
}


@end