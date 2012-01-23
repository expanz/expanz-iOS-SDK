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

#import <objc/message.h>
#import "Objection.h"
#import "NSData+Base64.h"
#import "expanz_model_SessionContext.h"
#import "expanz_model_ActivityDefinition.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Message.h"
#import "expanz_model_GridData.h"
#import "expanz_model_Row.h"
#import "expanz_model_TextCell.h"
#import "expanz_model_ImageCell.h"
#import "expanz_model_Field.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_service_ActivityClientDelegate.h"
#import "expanz_service_DeltaRequest.h"
#import "expanz_service_DataPublicationRequest.h"
#import "MBProgressHUD.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_ModelAdapter.h"
#import "expanz_ui_NavigationManager.h"
#import "MBProgressHUD.h"

/* ================================================================================================================== */
@interface expanz_ui_ActivityInstanceViewController (private)

- (void) showLoadingHud;

- (void) hideLoadingHud;

@end


/* ================================================================================================================== */
@implementation expanz_ui_ActivityInstanceViewController

@synthesize activityDefinition = _activityDefinition;
@synthesize activityInstance = _activityInstance;
@synthesize modelAdapter = _modelAdapter;
@synthesize spinner = _spinner;


/* ================================================== Initializers ================================================== */
- (id) initWithActivityDefinition:(expanz_model_ActivityDefinition*)activityDefinition nibName:(NSString*)nibName
                       initialKey:(NSString*)initialKey {

    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        _activityClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_ActivityClient)];
        _activityManager = [[JSObjection globalInjector] getObject:[NavigationManager class]];
        _activityDefinition = activityDefinition;
        self.title = _activityDefinition.title;
        _activityRequest = [[CreateActivityRequest alloc]
            initWithActivityName:activityDefinition.name style:activityDefinition.style initialKey:initialKey
                    sessionToken:[SessionContext globalContext].sessionToken];

        [_spinner startAnimating];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) sendDeltaForField:(Field*)field {
    if ([field isDirty]) {
        [_spinner startAnimating];
        DeltaRequest* deltaRequest = [DeltaRequest forField:field];
        [_activityClient sendDeltaWith:deltaRequest delegate:self];
    }
}

- (void) sendMethodInvocation:(NSString*)methodName {
    [_currentlyEditingField resignFirstResponder];

    while ([_activityInstance allowsMethodInvocations] == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        LogDebug(@"Waiting for model synchronization. . . ");
        usleep(5000000);
    }
    MethodInvocationRequest* methodRequest =
        [[MethodInvocationRequest alloc] initWithActivityInstance:_activityInstance methodName:methodName];
    [_spinner startAnimating];
    [_activityClient sendMethodInvocationWith:methodRequest delegate:self];
}

/* ================================================================================================================== */
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

/* ================================================================================================================== */
- (void) willCommenceEditForImageView:(UIButton*)sender {
    _currentlyEditingImageView = [_modelAdapter imageViewFor:sender];
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    [self presentModalViewController:imagePicker animated:YES];
}


/* ================================================================================================================== */
#pragma mark - View lifecycle


- (void) viewDidLoad {
    [super viewDidLoad];
    [_activityClient createActivityWith:_activityRequest delegate:self];
    [self showLoadingHud];
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
    for (GridData* dataSet in [_activityInstance dataSets]) {
        for (Row* row in [dataSet rows]) {
            for (ImageCell* imageCell in [row imageCells]) {
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
#pragma mark Image Picker Delegate 

- (void) imagePickerController:(UIImagePickerController*)picker didFinishPickingImage:(UIImage*)image
                   editingInfo:(NSDictionary*)editingInfo {

    Field* field = [_modelAdapter fieldFor:_currentlyEditingImageView];
    //[field didFinishEditWithValue:image];

    NSData* jpegRepresentation = UIImageJPEGRepresentation(image, 4.0);

    NSString* data = [jpegRepresentation base64EncodedString];
    NSString* sessionToken = [SessionContext globalContext].sessionToken;

    DeltaRequest* deltaRequest = [[DeltaRequest alloc]
        initWithFieldId:field.fieldId fieldValue:data activityHandle:_activityInstance.handle sessionToken:sessionToken
               encoding:DeltaEncodingBase64];
    [_activityClient sendDeltaWith:deltaRequest delegate:self];

    _currentlyEditingImageView.image = image;
    _currentlyEditingImageView = nil;
    [picker dismissModalViewControllerAnimated:YES];
}


/* ================================================================================================================== */
#pragma mark CreateActivityClientDelegate

- (void) requestDidFinishWithActivityInstance:(ActivityInstance*)activityInstance {
    [_spinner stopAnimating];
    if (_activityInstance == nil) {
        [self hideLoadingHud];
        _activityInstance = activityInstance;
        _modelAdapter = [[ModelAdapter alloc] initWithViewController:self];
        [_modelAdapter updateUIControlsWithModelValues];
    }

    for (Field* field in activityInstance.fields) {
        [[_activityInstance fieldWithId:field.fieldId] didSynchronizeStateWithServerModel:field.value];
        [[_modelAdapter textInputControlFor:field] setText:field.value];
    }
    //TODO: This should use id<expanz_ui_SystemEventReporter>
    for (Message* message in activityInstance.messages) {
        UIAlertView* alert = [[UIAlertView alloc]
            initWithTitle:@"System Message" message:message.content delegate:self cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
        [alert show];
    }
}

- (void) requestDidFailWithError:(NSError*)error {

}

/* ================================================== Private Methods =============================================== */
- (void) showLoadingHud {
    _subViewStateCache = [[NSMutableDictionary alloc] init];
    unsigned int generatedTag;
    for (UIView* view in [self.view subviews]) {
        //TODO: Fix this stupid way to get the pointer value as in integer;
        if (view.tag == 0) {
            NSScanner* scanner = [NSScanner scannerWithString:[NSString stringWithFormat:@"%p", view]];
            [scanner scanHexInt:&generatedTag];
            [view setTag:generatedTag];
        }
        else {
            generatedTag = view.tag;
        }
        [_subViewStateCache
            setObject:[NSNumber numberWithBool:view.hidden] forKey:[NSNumber numberWithInt:generatedTag]];
        [view setHidden:YES];
    }
    _loadingHud = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_loadingHud];

    _loadingHud.delegate = self;
    _loadingHud.labelText = @"Loading";
    [_loadingHud show:YES];


}

- (void) hideLoadingHud {
    for (NSNumber* tag in [_subViewStateCache allKeys]) {
        UIView* view = [self.view viewWithTag:[tag intValue]];
        BOOL hidden = [[_subViewStateCache objectForKey:tag] boolValue];
        LogDebug(@"Setting view with tag '%@' to hidden: %@", tag, hidden == YES ? @"YES" : @"NO");
        [view setHidden:hidden];
    }
    _subViewStateCache = nil;
    [_loadingHud hide:YES];
}


@end