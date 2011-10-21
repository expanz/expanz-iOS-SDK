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
#import "MARTNSObject.h"
#import "RTMethod.h"

/* ================================================================================================================== */

@interface expanz_ui_ActivityInstanceViewController (private) 
    
- (id<expanz_service_ActivityClient>) activityClient;
- (void) sendDeltaForField:(UITextField*)textField;
- (void) sendMethodInvocation:(NSString*)methodName;
- (void) tellKeyboardToClose;
- (expanz_model_Field*) modelFor:(UITextField*)textField;
- (NSArray*) fieldAccessors; 

@end

/* ================================================================================================================== */


@implementation expanz_ui_ActivityInstanceViewController

@synthesize activityInstance = _activityInstance;

@synthesize spinner = _spinner;
@synthesize Op1Label = _Op1Label;
@synthesize Op2Label = _Op2Label;
@synthesize ResultField = _ResultField;
@synthesize Op1Field = _Op1Field;
@synthesize Op2Field = _Op2Field;
@synthesize add = _add; 
@synthesize subtract = _subtract;
@synthesize multiply = _multiply;
@synthesize divide = _divide;


/* ================================================== Constructors ================================================== */

-(id) initWithActivity:(Activity*)activity {
    self = [super initWithNibName:@"ActivityInstance" bundle:[NSBundle mainBundle]];
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
    [self sendDeltaForField:_Op1Field];
}

- (IBAction) o21ValueChanged {
    [self sendDeltaForField:_Op2Field];
}

- (void) addClicked {
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
    [_spinner stopAnimating];
    if (_activityInstance == nil) {
        _activityInstance = [activityInstance retain];    
        [_Op1Field setEnabled:YES]; 
        [_Op2Field setEnabled:YES];
    }
    else {                    
        for (Field* field in activityInstance.fields) {                
            [[_activityInstance fieldWithId:field.fieldId] didSynchronizeStateWithServerModel:field.value];            
            SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Field", field.fieldId]);            
            RTMethod* method = [[self class] rt_methodForSelector: sel];                                
            UITextField* uiComponent; 
            [method returnValue: &uiComponent sendToTarget: self];
            [uiComponent setText:[field value]];                        
        }        
    }
}

- (void) requestDidFailWithError:(NSError*)error {
    
}



/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_spinner release];
    [_Op1Label release]; 
    [_Op2Label release];
    [_ResultField release];
    [_Op1Field release];
    [_Op2Field release];
    [_add release]; 
    [_subtract release]; 
    [_multiply release]; 
    [_divide release];
    [super dealloc];
}


/* ================================================== Private Methods =============================================== */

- (id<expanz_service_ActivityClient>) activityClient {
    return [[JSObjection globalInjector] getObject:@protocol(expanz_service_ActivityClient)];
}

- (void) sendDeltaForField:(UITextField*)textField {   
    Field* field = [self modelFor:textField]; 
    [field didFinishEditWithValue:textField.text];
    if ([field isDirty]) {
        [_spinner startAnimating];
        [[self activityClient] sendDeltaWith:[field asDeltaRequest] delegate:self];    
    }
}

- (void) sendMethodInvocation:(NSString*)methodName {    
    [self tellKeyboardToClose];

    while ([_activityInstance allowsMethodInvocations] == NO) { 
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        LogDebug(@"Waiting for model synchronization. . . ");
        usleep(50000); \
    }
    MethodInvocationRequest* methodRequest = [[MethodInvocationRequest alloc] 
                                              initWithActivityInstance:_activityInstance methodName:methodName]; 
    [_spinner startAnimating];
    [[self activityClient] sendMethodInvocationWith:methodRequest delegate:self];
    [methodRequest release];    
}

- (expanz_model_Field*) modelFor:(UITextField *)textField {
    for (RTMethod* method in [self fieldAccessors]) {
        UITextField* uiComponent; 
        [method returnValue: &uiComponent sendToTarget: self];
        if (uiComponent == textField) {
            LogDebug(@"!!!!!!!!!!!!!!! Got it!!!!!!!!!!!");
            NSString* selectorName = [method selectorName];
            NSString* fieldId = [selectorName substringToIndex:[selectorName rangeOfString:@"Field"].location];
            return [_activityInstance fieldWithId:fieldId]; 
        }
    }
    return nil;
}

- (NSArray*) fieldAccessors {
    NSArray* classMethods = [[self class] rt_methods]; 
    NSMutableArray* fieldAccessors = [[[NSMutableArray alloc] init] autorelease];
    for (RTMethod* method in classMethods) {
        if ([[method selectorName] hasSuffix:@"Field"]) {
            [fieldAccessors addObject:method]; 
        }        
    }
    return fieldAccessors;
}

- (void) tellKeyboardToClose {
    [_Op1Field resignFirstResponder]; 
    [_Op2Field resignFirstResponder];    
}

@end
