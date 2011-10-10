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

#import "expanz_ui_ActivityViewController.h"
#import "Objection.h"
#import "expanz_service_SessionContextHolder.h"

@implementation expanz_ui_ActivityViewController

@synthesize sessionDataClient = _sessionDataClient;

/* ================================================ Delegate Methods ================================================ */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/* ================================================================================================================== */
#pragma mark - View lifecycle
- (void) viewDidLoad {
    [super viewDidLoad];
    _sessionDataClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_SessionDataClient)];
    SessionDataRequest* sessionDataRequest = [[SessionDataRequest alloc] 
                                              initWithSessionToken:[SessionContextHolder globalContext].sessionToken];
    [_sessionDataClient retrieveSessionDataWith:sessionDataRequest delegate:self];
    [sessionDataRequest release];
}

- (void) viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* ================================================================================================================== */
#pragma mark SessionDataClientDelegate 

- (void) requestDidFinishWithMenu:(Menu*)menu {
    LogDebug(@"Got menu - %@", menu);    
}

- (void) requestDidFailWithError:(NSError*)error {
    
}

@end
