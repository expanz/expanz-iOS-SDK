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
#import "expanz_ui_components_TextFieldTableCell.h"
#import "expanz_iOS_SDKConfiguration.h"
#import "expanz_ui_NavigationManager.h"


@implementation expanz_ui_LoginViewController

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;

@synthesize loginClient = _loginClient;
@synthesize loginButton = _loginButton;
@synthesize spinner = _spinner;
@synthesize userNameAndPasswordForm = _userNameAndPasswordForm;
@synthesize userNameCell = _userNameCell;
@synthesize passwordCell = _passwordCell;


/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super initWithNibName:@"Login" bundle:[NSBundle mainBundle]];
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
    if (!_scrolled) {

        CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
        if (textFieldRect.origin.y >= 285) {
            _scrolled = YES;
            CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
            CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
            CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
            CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
            CGFloat heightFraction = numerator / denominator;
            if (heightFraction < 0.0) {
                heightFraction = 0.0;
            }
            else if (heightFraction > 1.0) {
                heightFraction = 1.0;
            }
            UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
            if (orientation == UIInterfaceOrientationPortrait || orientation ==
                UIInterfaceOrientationPortraitUpsideDown) {
                _animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
            }
            else {
                _animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
            }
            CGRect viewFrame = self.view.frame;
            viewFrame.origin.y -= _animatedDistance;

            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
            [self.view setFrame:viewFrame];
            [UIView commitAnimations];
        }
    }
}

- (void) textFieldDidEndEditing:(UITextField*)textField {
    if (_scrolled) {
        _scrolled = NO;
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y += _animatedDistance;

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        [self.view setFrame:viewFrame];
        [UIView commitAnimations];
    }
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

    SDKConfiguration* configuration = [SDKConfiguration globalConfiguration];
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
