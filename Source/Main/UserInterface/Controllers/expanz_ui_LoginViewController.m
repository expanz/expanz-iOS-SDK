////////////////////////////////////////////////////////////////////////////////
//
//  EXPANZ
//  Copyright 2008-2011 EXPANZ
//  All Rights Reserved.
//
//  NOTICE: Expanz permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////y


#import "Objection.h"
#import "expanz_model_SessionContext.h"
#import "expanz_service_SessionDataRequest.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_ui_LoginViewController.h"
#import "expanz_SdkConfiguration.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_ui_TextInputUtils.h"


@implementation expanz_ui_LoginViewController

@synthesize loginClient = _loginClient;
@synthesize loginButton = _loginButton;
@synthesize spinner = _spinner;
@synthesize userNameAndPasswordForm = _userNameAndPasswordForm;
@synthesize userNameCell = _userNameCell;
@synthesize passwordCell = _passwordCell;


/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super initWithNibName:@"Login" bundle:[NSBundle bundleForClass:[LoginViewController class]]];
    if (self) {
        _loginClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_LoginClient)];
        _navigationManager = [[JSObjection globalInjector] getObject:[NavigationManager class]];
        _reporter = [[JSObjection globalInjector] getObject:@protocol(expanz_ui_SystemEventReporter)];
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
    _userNameAndPasswordForm.backgroundColor = [UIColor clearColor];
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
#pragma mark Login and Password Form

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}


- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {

    if ([indexPath row] == 0) {
        return self.userNameCell;
    }
    else {
        return self.passwordCell;
    }
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 44;
}

/* ================================================================================================================== */
#pragma mark UITextFieldDelegate    

- (void) textFieldDidBeginEditing:(UITextField*)textField {
    [[TextInputUtils sharedTextInputUtils] revealFromBeneathKeyboard:textField];
}

- (void) textFieldDidEndEditing:(UITextField*)textField {
    [[TextInputUtils sharedTextInputUtils] restoreBeneathKeyboard:textField];
}

- (BOOL) textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    if (textField == _userNameCell.textField) {
        [_passwordCell.textField becomeFirstResponder];
    }
    else if (textField == _passwordCell.textField && _userNameCell.textField.text.length > 0 &&
        _passwordCell.textField.text.length > 0) {

        [self loginWithUserNameAndPassword:nil];
    }
    return YES;
}

/* ================================================================================================================== */
#pragma mark User Actions

- (void) loginWithUserNameAndPassword:(id)sender {
    _loginButton.enabled = NO;
    _userNameCell.textField.enabled = NO;
    _passwordCell.textField.enabled = NO;
    [_spinner startAnimating];

    SdkConfiguration* configuration = [SdkConfiguration globalConfiguration];
    NSString* user = _userNameCell.textField.text;
    NSString* password = _passwordCell.textField.text;
    NSString* appSite = configuration.preferredSite;
    NSString* userType = configuration.userType;

    SessionRequest* sessionRequest =
        [[SessionRequest alloc] initWithUserName:user password:password appSite:appSite userType:userType];
    [_loginClient createSessionWith:sessionRequest delegate:self];
}


/* ================================================================================================================== */
#pragma mark LoginClient delegate

- (void) requestDidFinishWithSessionContext:(SessionContext*)sessionContext {
    LogDebug(@"Request finished. Has error? %@", sessionContext.hasError ? @"YES" : @"NO");
    [_spinner stopAnimating];

    if (sessionContext.hasError) {
        _loginButton.enabled = YES;
        _userNameCell.textField.enabled = YES;
        _passwordCell.textField.enabled = YES;
        UIAlertView* alert = [[UIAlertView alloc]
            initWithTitle:@"Error" message:sessionContext.message delegate:self cancelButtonTitle:@"OK"
        otherButtonTitles:nil];
        [alert show];
    }
    else {
        [SessionContext setGlobalContext:sessionContext];
        [_navigationManager showMainMenu];
    }
}

- (void) requestDidFailWithError:(NSError*)error {
    [_reporter reportErrorWithReason:@"There was an an unrecoverable system error accessing session data"];
}

@end
