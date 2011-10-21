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
#import "expanz_model_Field+DeltaRequest.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_ui_ActivityInstanceViewController.h"
/* ================================================================================================================== */

@interface expanz_ui_ActivityInstanceViewController (private) 
    
- (id<expanz_service_ActivityClient>) activityClient;
- (void) sendDeltaForField:(UITextField*)textField;
- (void) sendMethodInvocation:(NSString*)methodName;
- (void) tellKeyboardToClose;

@end

/* ================================================================================================================== */


@implementation expanz_ui_ActivityInstanceViewController

@synthesize activityInstance = _activityInstance;

@synthesize op1Label = _op1Label;
@synthesize op2Label = _op2Label;
@synthesize result = _result;
@synthesize op1Field = _op1Field;
@synthesize op2Field = _op2Field;
@synthesize add = _add; 
@synthesize subtract = _subtract;
@synthesize multiply = _multiply;
@synthesize divide = _divide;


/* ================================================== Constructors ================================================== */

-(id) initWithActivity:(Activity*)activity {
    self = [super initWithNibName:@"ActivityInstance" bundle:[NSBundle mainBundle]];
    if (self) {
        self.title = activity.title;        
        id<expanz_service_ActivityClient> activityClient = [self activityClient];
        CreateActivityRequest* activityRequest = [[CreateActivityRequest alloc] initWithActivityName:activity.name 
                                                        sessionToken:[SessionContext globalContext].sessionToken];        
        [activityClient createActivityWith:activityRequest delegate:self];
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
#pragma mark UITextFieldDelegate    


- (IBAction) op1ValueChanged {
    [self sendDeltaForField:_op1Field];
}

- (IBAction) o21ValueChanged {
    [self sendDeltaForField:_op2Field];
}

- (IBAction) addClicked {
    [self sendMethodInvocation:@"Add"];
}

- (IBAction) subtractClicked {
    [self sendMethodInvocation:@"Subtract"];  
    
}

- (IBAction) multiplyClicked {
    [self sendMethodInvocation:@"Multiply"];
    
}

- (IBAction) divideClicked {
    [self sendMethodInvocation:@"Divide"];
}


/* ================================================================================================================== */
#pragma mark CreateActivityClientDelegate

- (void) requestDidFinishWithActivityInstance:(ActivityInstance*)activityInstance {
    if (_activityInstance == nil) {
        _activityInstance = [activityInstance retain];    
        [_op1Field setEnabled:YES]; 
        [_op2Field setEnabled:YES];
    }
    else {                    
        for (Field* field in activityInstance.fields) {
            LogDebug(@"Field: %@", field.fieldId);
            
            [[_activityInstance fieldWithId:field.fieldId] didSynchronizeStateWithServerModel:field.value];
            
            //TODO: Make this dynamic
            if ([field.fieldId isEqualToString:@"Op1"]) {
                LogDebug(@"Setting Op1");
                [_op1Field setText:[field value]];
            }
            else if ([field.fieldId isEqualToString:@"Op2"]) {
                LogDebug(@"Setting Op2");
                [_op2Field setText:[field value]];
            }
            else if ([field.fieldId isEqualToString:@"Result"]) {
                LogDebug(@"Setting Result");
                [_result setText:[field value]];
            }
        }        
    }
}

- (void) requestDidFailWithError:(NSError*)error {
    
}



/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_op1Label release]; 
    [_op2Label release];
    [_result release];
    [_op1Field release];
    [_op2Field release];
    [_add release]; 
    [_subtract release]; 
    [_multiply release]; 
    [_divide release];
}


/* ================================================== Private Methods =============================================== */

- (id<expanz_service_ActivityClient>) activityClient {
    return [[[JSObjection globalInjector] getObject:@protocol(expanz_service_ActivityClient)] autorelease];
}

- (void) sendDeltaForField:(UITextField*)textField {    
    Field* field;
    if (textField == _op1Field) {
        field = [_activityInstance fieldWithId:@"Op1"];
    }
    else if (textField == _op2Field) {
        field = [_activityInstance fieldWithId:@"Op2"];
    }
    [field didFinishEditWithValue:textField.text];
    id<expanz_service_ActivityClient> activityClient = [self activityClient];
    [activityClient sendDeltaWith:[field asDeltaRequest] delegate:self];    
}

- (void) sendMethodInvocation:(NSString*)methodName {    
    [self tellKeyboardToClose];

    while ([_activityInstance allowsMethodInvocations] == NO) { 
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        LogDebug(@"Waiting for model synchronization. . . ");
        usleep(50000); \
    }
    
    id<expanz_service_ActivityClient> activityClient = [self activityClient];
    MethodInvocationRequest* methodRequest = [[MethodInvocationRequest alloc] 
                                              initWithActivityInstance:_activityInstance methodName:methodName]; 
    [activityClient sendMethodInvocationWith:methodRequest delegate:self];
    [methodRequest release];    
}

- (void) tellKeyboardToClose {
    [_op1Field resignFirstResponder]; 
    [_op2Field resignFirstResponder];    
}

@end
