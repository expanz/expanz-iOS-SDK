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
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_model_SessionContext.h"
#import "expanz_model_Activity.h"
#import "expanz_model_ActivityInstance.h"


@implementation expanz_ui_ActivityInstanceViewController

@synthesize activityClient = _activityClient;

/* ================================================== Constructors ================================================== */

-(id) initWithActivity:(Activity*)activity {
    self = [super initWithNibName:@"ActivityInstance" bundle:[NSBundle mainBundle]];
    if (self) {
        self.title = activity.title;
        _activityClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_ActivityClient)];
        CreateActivityRequest* activityRequest = [[CreateActivityRequest alloc] initWithActivityName:activity.name 
                                                        sessionToken:[SessionContext globalContext].sessionToken];        
        [_activityClient createActivityWith:activityRequest delegate:self];
    }
    return self;
}



/* ================================================ Delegate Methods ================================================ */
- (void) didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/* ================================================================================================================== */
#pragma mark - View lifecycle

- (void) viewDidLoad {
    [super viewDidLoad];
}


- (void) viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* ================================================================================================================== */
#pragma mark CreateActivityClientDelegate

- (void) requestDidFinishWithActivityInstance:(ActivityInstance*)activityInstance {
    LogDebug(@"%@", activityInstance);
    
}

- (void) requestDidFailWithError:(NSError*)error {
    
}

@end
