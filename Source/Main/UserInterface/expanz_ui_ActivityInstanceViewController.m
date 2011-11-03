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
#import "expanz_model_ActivityDefinition.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Message.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_ModelAdapter.h"
#import "expanz_model_Field.h"
#import "expanz_service_DeltaRequest.h"
#import "expanz_service_DataPublicationRequest.h"
#import "expanz_model_DataSet.h"
#import "expanz_model_Row.h"
#import "expanz_model_TextCell.h"


@implementation expanz_ui_ActivityInstanceViewController

@synthesize modelAdapter = _modelAdapter;
@synthesize activityInstance = _activityInstance;
@synthesize spinner = _spinner;


/* ================================================== Constructors ================================================== */
- (id) initWithActivity:(ActivityDefinition*)activity {
    self = [super initWithNibName:activity.name bundle:[NSBundle mainBundle]];
    if (self) {
        self.title = activity.title;
        NSString* sessionToken = [SessionContext globalContext].sessionToken;
        _activityRequest = [[CreateActivityRequest alloc]
            initWithActivityName:activity.name style:activity.style sessionToken:sessionToken];
        [_spinner startAnimating];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (id <expanz_service_ActivityClient>) activityClient {
    return [[JSObjection globalInjector] getObject:@protocol(expanz_service_ActivityClient)];
}

/* ================================================================================================================== */
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
    MethodInvocationRequest* methodRequest =
        [[MethodInvocationRequest alloc] initWithActivityInstance:_activityInstance methodName:methodName];
    [_spinner startAnimating];
    [[self activityClient] sendMethodInvocationWith:methodRequest delegate:self];
    [methodRequest release];
}

- (void) hasUITableView:(UITableView*)tableView requestingDataPublicationId:(NSString*)dataPublicationId {
    LogDebug(@"Requesting dataPublicationId: %@", dataPublicationId);
    DataPublicationRequest* publicationRequest = [_activityRequest dataPublicationRequestFor:tableView];
    [publicationRequest setDataPublicationId:dataPublicationId];
}

- (void) hasUITableView:(UITableView*)tableView requestingPopulateMethod:(NSString*)populateMethod {
    LogDebug(@"Requesting populateMethod: %@", populateMethod);
    DataPublicationRequest* publicationRequest = [_activityRequest dataPublicationRequestFor:tableView];
    [publicationRequest setPopulateMethod:populateMethod];
}

- (void) hasUITableView:(UITableView*)tableView requestingQuery:(NSString*)query {
    LogDebug(@"Requesting query: %@", query);
    DataPublicationRequest* publicationRequest = [_activityRequest dataPublicationRequestFor:tableView];
    [publicationRequest setQuery:query];
}


- (void) hasUITableView:(UITableView*)tableView requestingAutoPopulate:(BOOL)autoPopulate {
    LogDebug(@"Requesting autoPopulate: %@", autoPopulate == YES ? @"YES" : @"NO");
    DataPublicationRequest* publicationRequest = [_activityRequest dataPublicationRequestFor:tableView];
    [publicationRequest setAutoPopulate:autoPopulate];
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
    [[self activityClient] createActivityWith:_activityRequest delegate:self];
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
#pragma mark UITableViewDelegate

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    DataSet* dataSet = [_modelAdapter dataSetFor:tableView];
    return [dataSet.rows count];
}


-(UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    DataSet* dataSet = [_modelAdapter dataSetFor:tableView];
    NSString* reuseId = [dataSet dataId];
        
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseId] autorelease];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    Row* row = [dataSet.rows objectAtIndex:indexPath.row];
    TextCell* firstName = [row.cells objectAtIndex:3];
    TextCell* lastName = [row.cells objectAtIndex:4];
    TextCell* email = [row.cells objectAtIndex:6];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", firstName.data, lastName.data];
    cell.detailTextLabel.text = email.data;

    return cell;

}

- (void) tableView: (UITableView*) tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath {

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
        [[_modelAdapter textInputControlFor:field] setText:field.value];
    }
    for (Message* message in activityInstance.messages) {
        UIAlertView* alert = [[UIAlertView alloc]
            initWithTitle:message.messageTypeAsString message:message.content delegate:self cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
}

- (void) requestDidFailWithError:(NSError*)error {

}



/* ================================================== Utility Methods =============================================== */
- (void) dealloc {    
    [_spinner release];
    [_activityRequest release];
    [_activityInstance release];
    [_modelAdapter release];
    [super dealloc];
}

@end