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

#import <Objection-iOS/Objection.h>
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
#import "expanz_model_ImageCell.h"
#import "expanz_ui_components_ThumbnailImageTableCell.h"
#import "expanz_ui_ActivityManager.h"


@implementation expanz_ui_ActivityInstanceViewController

@synthesize activityDefinition = _activityDefinition;
@synthesize activityInstance = _activityInstance;
@synthesize spinner = _spinner;
@synthesize tableCell;


/* ================================================== Constructors ================================================== */
- (id) initWithActivityDefinition:(expanz_model_ActivityDefinition*)activityDefinition nibName:(NSString*)nibName
                       initialKey:(NSString*)initialKey {

    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        _activityManager = [[JSObjection globalInjector] getObject:[ActivityManager class]];
        _activityDefinition = [activityDefinition retain];
        self.title = _activityDefinition.title;
        _activityRequest = [[CreateActivityRequest alloc]
            initWithActivityName:activityDefinition.name style:activityDefinition.style initialKey:initialKey
                    sessionToken:[SessionContext globalContext].sessionToken];
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

- (void) willCommenceEditForImageView:(UIButton*)sender {
    _currentlyEditingImageView = [_modelAdapter imageViewForEditButton:sender];
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentModalViewController:imagePicker animated:YES];
    [imagePicker release];
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

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    for (DataSet* dataSet in [_activityInstance dataSets]) {
        for (Row* row in [dataSet rows]) {
            for (ImageCell* imageCell in [row imageCells]) {
                [imageCell.image release];
                imageCell.image = nil;
                imageCell.hasAskedImageToLoad = NO;
            }
        }
    }
}


/* ================================================ Delegate Methods ================================================ */
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

- (BOOL) textFieldShouldReturn:(UITextField*)textField {
    return [self textFieldShouldEndEditing:textField];
}


/* ================================================================================================================== */
#pragma mark UITableViewDelegate

- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    DataSet* dataSet = [_modelAdapter dataSetFor:tableView];
    return [dataSet.rows count];
}


- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    DataSet* dataSet = [_modelAdapter dataSetFor:tableView];
    NSString* reuseId = [dataSet dataId];

    ThumbnailImageTableCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"TableCell2" owner:self options:nil];
        cell = self.tableCell;
        self.tableCell = nil;
    }

    Row* row = [dataSet.rows objectAtIndex:indexPath.row];

    TextCell* firstNameCell = (TextCell*) [row cellWithId:@"3"];
    TextCell* lastNameCell = (TextCell*) [row cellWithId:@"4"];
    TextCell* emailCell = (TextCell*) [row cellWithId:@"6"];
    ImageCell* imageCell = (ImageCell*) [row cellWithId:@"8"];
    if (imageCell.hasAskedImageToLoad == NO) {
        [imageCell loadImage];
    }
    [_modelAdapter startObserving:imageCell];

    cell.mainLabel.text = [NSString stringWithFormat:@"%@ %@", firstNameCell.text, lastNameCell.text];
    cell.subLabel.text = emailCell.text;
    cell.thumbnail.image = imageCell.image;
    cell.backgroundView.backgroundColor =
        (indexPath.row % 2) ? [UIColor colorWithRed:0.942 green:0.942 blue:0.942 alpha:1] :
            [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1];

    return cell;
}

- (void) tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    DataSet* dataSet = [_modelAdapter dataSetFor:tableView];
    Row* row = [dataSet.rows objectAtIndex:indexPath.row];
    TextCell* keyCell = (TextCell*) [row cellWithId:@"1"];

    ActivityDefinition* edit =
        [[ActivityDefinition alloc] initWithName:_activityDefinition.name title:@"Edit" style:ActivityStyleDetail];
    if ([_activityManager transitionToActivityWithDefinition:edit initialKey:keyCell.text]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 75;
}

/* ================================================================================================================== */
#pragma mark Image Picker Delegate 

- (void) imagePickerController:(UIImagePickerController*)picker didFinishPickingImage:(UIImage*)image
                   editingInfo:(NSDictionary*)editingInfo {

    _currentlyEditingImageView.image = image;
    NSData* data = UIImageJPEGRepresentation(image, 4.0);
    [picker dismissModalViewControllerAnimated:YES];
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
    [_activityDefinition release];
    [_activityInstance release];
    [_modelAdapter release];
    [super dealloc];
}

@end