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

#import "NSData+ExpanzAdditions.h"
#import <objc/message.h>
#import "Objection.h"
#import "MARTNSObject.h"
#import "expanz_model_SessionContext.h"
#import "expanz_model_menuItem.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Message.h"
#import "expanz_model_GridData.h"
#import "expanz_model_Row.h"
#import "expanz_model_TextGridDataCell.h"
#import "expanz_model_ImageGridDataCell.h"
#import "expanz_model_Field.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_service_DeltaRequest.h"
#import "expanz_service_DataPublicationRequest.h"
#import "MBProgressHUD.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_ModelAdapter.h"
#import "expanz_ui_TextInputUtils.h"
#import "RTProperty.h"
#import "expanz_ui_utils_ViewTagger.h"


/* ================================================================================================================== */
@interface expanz_ui_ActivityInstanceViewController (private)

- (void) cachePropertyNames;

- (void) showLoadingHud;

- (void) hideLoadingHud;

@end


/* ================================================================================================================== */
@implementation expanz_ui_ActivityInstanceViewController


@synthesize propertyNames = _propertyNames;
@synthesize activityInstance = _activityInstance;
@synthesize modelAdapter = _modelAdapter;
@synthesize spinner = _spinner;
@synthesize searchBar = _searchBar;
@synthesize activityId = _activityId;
@synthesize style = _style;


/* ================================================== Initializers ================================================== */
- (id) initWithActivityId:(NSString*)activityId title:(NSString*)title style:(expanz_model_ActivityStyle*)style
        initialKey:(NSString*)initialKey nibName:(NSString*)nibName data:(expanz_model_ActivityInstance*)data {

    self = [super initWithNibName:nibName bundle:[NSBundle mainBundle]];
    if (self) {
        _activityClient = [[JSObjection globalInjector] getObject:@protocol(ExpanzActivityClient)];
        _activityId = [activityId copy];
        [self setTitle:title];
        _style = style;
        if (data != nil) {
            _activityInstance = data;
            _shouldInitializeModelAdapterOnNextResponse = YES;
        }
        [self cachePropertyNames];
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
    [self sendMethodInvocation:methodName withDelegate:self];
}

- (void) sendMethodInvocation:(NSString*)methodName withDelegate:(expanz_ui_ActivityInstanceViewController*)delegate {
    LogDebug(@"Sending method invocation: %@", methodName);
    id<UITextInput> currentlyEditingTextInput = [[TextInputUtils sharedTextInputUtils] currentlyEditingTextInput];
    [[currentlyEditingTextInput textInputView] resignFirstResponder];

    while ([_activityInstance allowsMethodInvocations] == NO) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        LogDebug(@"Waiting for model synchronization. . . ");
        usleep(5000);
    }
    MethodInvocationRequest* methodRequest =
            [[MethodInvocationRequest alloc] initWithActivityInstance:_activityInstance methodName:methodName];
    [_spinner startAnimating];
    [_activityClient sendMethodInvocationWith:methodRequest delegate:delegate];
}


/* ================================================================================================================== */
- (void) hasUITableView:(UITableView*)tableView requestingDataBinding:(BOOL)dataBinding {
    [_activityRequest dataPublicationRequestFor:[NSValue valueWithPointer:(__bridge void*) tableView]];
}

- (void) hasUITableView:(UITableView*)tableView requestingPopulateMethod:(NSString*)populateMethod {
    LogDebug(@"Requesting populateMethod: %@", populateMethod);
    DataPublicationRequest* publicationRequest =
            [_activityRequest dataPublicationRequestFor:[NSValue valueWithPointer:(__bridge void*) tableView]];
    [publicationRequest setPopulateMethod:populateMethod];
}

- (void) hasUITableView:(UITableView*)tableView requestingQuery:(NSString*)query {
    LogDebug(@"Requesting query: %@", query);
    DataPublicationRequest* publicationRequest =
            [_activityRequest dataPublicationRequestFor:[NSValue valueWithPointer:(__bridge void*) tableView]];
    [publicationRequest setQuery:query];
}

- (void) hasUITableView:(UITableView*)tableView requestingAutoPopulate:(BOOL)autoPopulate {
    LogDebug(@"Requesting autoPopulate: %@", autoPopulate == YES ? @"YES" : @"NO");
    DataPublicationRequest* publicationRequest =
            [_activityRequest dataPublicationRequestFor:[NSValue valueWithPointer:(__bridge void*) tableView]];
    [publicationRequest setAutoPopulate:autoPopulate];
}

- (void) hasUITableView:(UITableView*)tableView requestingContextObject:(NSString*)contextObject {
    LogDebug(@"Requesting contextObject: %@", contextObject);
    DataPublicationRequest* publicationRequest =
            [_activityRequest dataPublicationRequestFor:[NSValue valueWithPointer:(__bridge void*) tableView]];
    [publicationRequest setContextObject:contextObject];
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
    LogDebug(@"@@@@@@ VIEW DID LOAD");
    for (DataPublicationRequest* publicationRequest in [_activityRequest dataPublicationRequests]) {
        if (publicationRequest.dataPublicationId == nil) {
            for (NSString* propertyName in [self propertyNames]) {
                NSObject* object = objc_msgSend(self, NSSelectorFromString(propertyName));

                UITableView* tableView =
                        (__bridge id) [[_activityRequest keyForDataPublicationRequest:publicationRequest] pointerValue];
                if (object == tableView) {
                    [publicationRequest setDataPublicationId:propertyName];
                }
            }
        }
    }

    if (_activityRequest) {
        [_activityClient createActivityWith:_activityRequest delegate:self];
    }

    if (_activityInstance == nil || _shouldInitializeModelAdapterOnNextResponse) {
        [self showLoadingHud];
    }

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
            for (ImageGridDataCell* imageCell in [row imageCells]) {
                imageCell.imageData = nil;
                imageCell.hasAskedImageToLoad = NO;
            }
        }
    }
}

/* ================================================ Delegate Methods ================================================ */
#pragma mark UITextFieldDelegate

- (void) textFieldDidBeginEditing:(UITextField*)textField {
    TextInputUtils* textInputUtils = [TextInputUtils sharedTextInputUtils];
    [textInputUtils setCurrentlyEditingTextInput:textField];
    [textInputUtils revealFromBeneathKeyboard:textField];
}

- (void) textFieldDidEndEditing:(UITextField*)textField {
    [[TextInputUtils sharedTextInputUtils] restoreBeneathKeyboard:textField];
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
#pragma mark UITextViewDelegate

- (void) textViewDidBeginEditing:(UITextView*)textView {
    TextInputUtils* textInputUtils = [TextInputUtils sharedTextInputUtils];
    [textInputUtils setCurrentlyEditingTextInput:textView];
    [textInputUtils revealFromBeneathKeyboard:textView];
    [textInputUtils showKeyboardUtilsInView:self.view];
}

- (void) textViewDidEndEditing:(UITextView*)textView {
    LogDebug(@"Done editing!");
    [[TextInputUtils sharedTextInputUtils] restoreBeneathKeyboard:textView];
    Field* field = [_modelAdapter fieldFor:textView];
    [field didFinishEditWithValue:textView.text];
    [self sendDeltaForField:field];
}

/* ================================================================================================================== */
#pragma mark Image Picker Delegate 

- (void) imagePickerController:(UIImagePickerController*)picker didFinishPickingImage:(UIImage*)image
        editingInfo:(NSDictionary*)editingInfo {

    Field* field = [_modelAdapter fieldFor:_currentlyEditingImageView];

    NSData* jpegRepresentation = UIImageJPEGRepresentation(image, 4.0);

    NSString* data = [jpegRepresentation base64EncodedString];
    NSString* sessionToken = [SessionContext globalContext].sessionToken;

    DeltaRequest* deltaRequest = [[DeltaRequest alloc]
            initWithFieldId:field.fieldId fieldValue:data activityHandle:_activityInstance.handle
            sessionToken:sessionToken encoding:DeltaEncodingBase64];
    //LogDebug(@"Here's the delta request: %@", deltaRequest);
    [_activityClient sendDeltaWith:deltaRequest delegate:self];

    _currentlyEditingImageView.image = image;
    _currentlyEditingImageView = nil;
    [picker dismissModalViewControllerAnimated:YES];
}


/* ================================================================================================================== */
#pragma mark CreateActivityClientDelegate

- (void) requestDidFinishWithActivityInstance:(ActivityInstance*)activityInstance {
    LogDebug(@"Controller %@, got activity: %@", self.title, activityInstance);
    [_spinner stopAnimating];

    if (_activityInstance == nil) {
        _activityInstance = activityInstance;
        _shouldInitializeModelAdapterOnNextResponse = YES;
    }

    if (_shouldInitializeModelAdapterOnNextResponse) {
        LogDebug(@"OK init model adapter");
        [self hideLoadingHud];
        _modelAdapter = [[ModelAdapter alloc] initWithViewController:self];
        [_modelAdapter updateUIControlsWithModelValues];
        _shouldInitializeModelAdapterOnNextResponse = NO;
    }

    for (Field* field in activityInstance.fields) {
        LogDebug(@"Field: '%@' has value '%@'", field.fieldId, field.value);
        [[_activityInstance fieldWithId:field.fieldId] didSynchronizeStateWithServerModel:field.value];
        [[_modelAdapter textFieldFor:field] setText:field.value];
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
- (void) cachePropertyNames {
    NSMutableArray* propertyNames = [[NSMutableArray alloc] init];
    for (RTProperty* property in [[self class] rt_properties]) {
        [propertyNames addObject:[property name]];
    }
    _propertyNames = [NSArray arrayWithArray:propertyNames];
}

- (void) attachToServerWithInitialKey:(NSString*)initialKey {
    _activityRequest = [[CreateActivityRequest alloc]
            initWithActivityName:_activityId style:_style initialKey:initialKey
            sessionToken:[SessionContext globalContext].sessionToken];
}

/* ================================================================================================================== */
- (void) showLoadingHud {
    if (_loadingHud == nil) {
        _loadingHud = [[MBProgressHUD alloc] initWithView:self.view];
    }
    _loadingHud.delegate = self;
    _loadingHud.labelText = @"Loading";
    _subViewStateCache = [[NSMutableDictionary alloc] init];
    for (UIView* view in [self.view subviews]) {

        NSNumber* viewTag = [NSNumber numberWithInt:[ViewTagger tagForView:view]];
        [_subViewStateCache setObject:[NSNumber numberWithBool:view.hidden] forKey:viewTag];
        [view setHidden:YES];
    }

    [self.view addSubview:_loadingHud];
    [_loadingHud show:YES];
}

- (void) hideLoadingHud {
    [_loadingHud hide:YES];
    for (NSNumber* tag in [_subViewStateCache allKeys]) {
        UIView* view = [self.view viewWithTag:[tag intValue]];
        BOOL hidden = [[_subViewStateCache objectForKey:tag] boolValue];
        [view setHidden:hidden];
    }
    _subViewStateCache = nil;
}

@end