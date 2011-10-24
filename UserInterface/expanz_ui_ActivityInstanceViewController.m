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
#import "expanz_model_Message.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "MARTNSObject.h"
#import "RTMethod.h"


@implementation expanz_ui_ActivityInstanceViewController

@synthesize activityInstance = _activityInstance;
@synthesize spinner = _spinner;


/* ================================================== Constructors ================================================== */

-(id) initWithActivity:(Activity*)activity {
    self = [super initWithNibName:@"BasicCalculator" bundle:[NSBundle mainBundle]];
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

- (void) sendDeltaForField:(UITextField*)textField {   
    Field* field = [self fieldFor:textField]; 
    [field didFinishEditWithValue:textField.text];
    if ([field isDirty]) {
        [_spinner startAnimating];
        [[self activityClient] sendDeltaWith:[field asDeltaRequest] delegate:self];    
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

- (expanz_model_Field*) fieldFor:(UITextField *)textField {
    for (RTMethod* method in [self fieldAccessors]) {
        UITextField* uiComponent; 
        [method returnValue: &uiComponent sendToTarget: self];
        if (uiComponent == textField) {
            NSString* selectorName = [method selectorName];
            NSString* fieldId = [selectorName substringToIndex:[selectorName rangeOfString:@"Field"].location];
            return [_activityInstance fieldWithId:fieldId]; 
        }
    }
    return nil;
}

- (NSSet*) uiControls {
    if (_uiControls == nil) {
        _uiControls = [[NSMutableSet alloc] initWithCapacity:[_activityInstance.fields count]];
        NSArray* classMethods = [[self class] rt_methods]; 
        for (RTMethod* method in classMethods) {
            if ([[method selectorName] hasSuffix:@"Field"]) {
                UIControl* uiComponent; 
                [method returnValue: &uiComponent sendToTarget: self];
                [_uiControls addObject:uiComponent];                 
            }            
        }
    }
    return _uiControls;
}

- (void) setFieldsEnabled:(BOOL)enabled {
    for (UIControl* uiControl in [self uiControls]) {
        [uiControl setEnabled:enabled];
    }
}

- (void) setFieldsHidden:(BOOL)enabled {
    for (UIControl* uiControl in [self uiControls]) {
        [uiControl setHidden:enabled];
    }
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
    [self setFieldsHidden:YES];
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
    [self sendDeltaForField:textField]; 
    return YES;
}


/* ================================================================================================================== */
#pragma mark CreateActivityClientDelegate

- (void) requestDidFinishWithActivityInstance:(ActivityInstance*)activityInstance {
    [_spinner stopAnimating];
    if (_activityInstance == nil) {
        _activityInstance = [activityInstance retain];    
        [self setFieldsHidden:NO];
    }                   
    for (Field* field in activityInstance.fields) {                
        [[_activityInstance fieldWithId:field.fieldId] didSynchronizeStateWithServerModel:field.value];            
        SEL sel = NSSelectorFromString([NSString stringWithFormat:@"%@Field", field.fieldId]);            
        RTMethod* method = [[self class] rt_methodForSelector: sel];                                
        UITextField* uiComponent; 
        [method returnValue: &uiComponent sendToTarget: self];
        [uiComponent setText:[field value]];                                
    }
    for (Message* message in activityInstance.messages) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"zzz" message:message.content delegate:self 
                                              cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
}

- (void) requestDidFailWithError:(NSError*)error {
    
}



/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_spinner release];
    [_activityInstance dealloc];
    [super dealloc];
}



@end
