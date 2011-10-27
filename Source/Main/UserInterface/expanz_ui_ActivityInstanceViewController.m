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
#import "expanz_model_SessionContext.h"
#import "expanz_model_Activity.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Message.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_ModelAdapter.h"
#import "expanz_model_Field.h"
#import "expanz_service_DeltaRequest.h"


@implementation expanz_ui_ActivityInstanceViewController

@synthesize modelAdapter = _modelAdapter;
@synthesize activityInstance = _activityInstance;
@synthesize spinner = _spinner;


/* ================================================== Constructors ================================================== */
-(id) initWithActivity:(Activity*)activity {
    self = [super initWithNibName:activity.name bundle:[NSBundle mainBundle]];
    if (self) {
        self.title = activity.title;    
        CreateActivityRequest* activityRequest = [[CreateActivityRequest alloc] initWithActivityName:activity.name 
                                                        sessionToken:[SessionContext globalContext].sessionToken];        
        [[self activityClient] createActivityWith:activityRequest delegate:self];
        [_spinner startAnimating];
        [activityRequest release];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (id<expanz_service_ActivityClient>) activityClient {
    return [[JSObjection globalInjector] getObject:@protocol(expanz_service_ActivityClient)];
}

- (void) sendDeltaForField:(Field*)field {   
    if ([field isDirty]) {
        [_spinner startAnimating];
        DeltaRequest* deltaRequest = [DeltaRequest fromField:field];
        [[self activityClient] sendDeltaWith:deltaRequest delegate:self];
    }
}

- (void) sendMethodInvocation:(NSString*)methodName {    
    [_currentlyEditingField resignFirstResponder];
    
    while ([_activityInstance allowsMethodInvocations] == NO) { 
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        LogDebug(@"Waiting for model synchronization. . . ");
        usleep(50000); 
    }
    MethodInvocationRequest* methodRequest = [[MethodInvocationRequest alloc] 
                                              initWithActivityInstance:_activityInstance methodName:methodName]; 
    [_spinner startAnimating];
    [[self activityClient] sendMethodInvocationWith:methodRequest delegate:self];
    [methodRequest release];    
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
#pragma mark UITextFieldDelegate

- (void) textFieldDidBeginEditing:(UITextField*)textField {
    _currentlyEditingField = textField;
}

- (BOOL) textFieldShouldEndEditing:(UITextField*)textField {
    [textField resignFirstResponder]; 
    Field* field = [_modelAdapter fieldFor:textField]; 
    [field didFinishEditWithValue:textField.text];
    [self sendDeltaForField:field]; 
    return YES;
}


/* ================================================================================================================== */
#pragma mark CreateActivityClientDelegate

- (void) requestDidFinishWithActivityInstance:(ActivityInstance*)activityInstance {
    [_spinner stopAnimating];
    if (_activityInstance == nil) {
        _activityInstance = [activityInstance retain];
        _modelAdapter = [[ModelAdapter alloc] initWithViewController:self];
        [_modelAdapter updateUIControlsWithModelValues];
    } 
    
    for (Field* field in activityInstance.fields) {                
        [[_activityInstance fieldWithId:field.fieldId] didSynchronizeStateWithServerModel:field.value];
        [[_modelAdapter textControlFor:field] setText:field.value];
    }
    for (Message* message in activityInstance.messages) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:message.messageTypeAsString message:message.content 
                                                       delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void) requestDidFailWithError:(NSError*)error {
    
}



/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_spinner release];
    [_activityInstance release];
    [_modelAdapter release]; 
    [super dealloc];
}



@end
