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


#import <Objection-iOS/Objection.h>
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

/* ================================================== Initializers ================================================== */
- (id)init {
    self = [super initWithNibName:@"Login" bundle:[NSBundle mainBundle]];
    if (self) {
        _loginClient = [[[JSObjection globalInjector] getObject:@protocol(expanz_service_LoginClient)] retain];
        _navigationManager = [[[JSObjection globalInjector] getObject:[NavigationManager class]] retain];
        _reporter = [[[JSObjection globalInjector] getObject:@protocol(expanz_ui_SystemEventReporter)] retain];
    }
    return self;
}


/* ================================================ Delegate Methods ================================================ */
- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

/* ================================================================================================================== */
#pragma mark - View lifecycle



- (void)viewDidLoad {
    [super viewDidLoad];
    _userNameAndPasswordForm.backgroundColor = [UIColor clearColor];
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* ================================================================================================================== */
#pragma mark Login and Password Form

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    static NSString* reuseId = @"userNameAndPasswordForm";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[TextFieldTableCell alloc] initWithReuseIdentifier:reuseId] autorelease];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    TextFieldTableCell* textFieldCell = (TextFieldTableCell*) cell;
    textFieldCell.textField.delegate = self;

    if ([indexPath row] == 0) {
        textFieldCell.textLabel.text = @"User Name";
        textFieldCell.textField.placeholder = @"example@expanz.com";
        textFieldCell.textField.keyboardType = UIKeyboardTypeEmailAddress;
        textFieldCell.textField.returnKeyType = UIReturnKeyNext;
        _userNameField = [textFieldCell.textField retain];
    }
    else {
        textFieldCell.textLabel.text = @"Password";
        textFieldCell.textField.placeholder = @"required";
        textFieldCell.textField.keyboardType = UIKeyboardTypeDefault;
        textFieldCell.textField.returnKeyType = UIReturnKeyDone;
        textFieldCell.textField.secureTextEntry = YES;
        _passwordField = [textFieldCell.textField retain];
    }
    return cell;
}

/* ================================================================================================================== */
#pragma mark UITextFieldDelegate    

- (void)textFieldDidBeginEditing:(UITextField*)textField {
    if (!_scrolled) {
        _scrolled = YES;
        CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
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
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
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

- (void)textFieldDidEndEditing:(UITextField*)textField {
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

- (BOOL)textFieldShouldReturn:(UITextField*)textField {
    [textField resignFirstResponder];
    if (textField == _userNameField) {
        [_passwordField becomeFirstResponder];
    }
    else if (textField == _passwordField && _userNameField.text.length > 0 && _passwordField.text.length > 0) {
        [self loginWithUserNameAndPassword:nil];
    }
    return YES;
}

/* ================================================================================================================== */
#pragma mark User Actions

- (void)loginWithUserNameAndPassword:(id)sender {
    _loginButton.enabled = NO;
    _userNameField.enabled = NO;
    _passwordField.enabled = NO;
    [_spinner startAnimating];

    SDKConfiguration* configuration = [SDKConfiguration globalConfiguration];
    NSString* user = _userNameField.text;
    NSString* password = _passwordField.text;
    NSString* appSite = configuration.preferredSite;
    NSString* userType = configuration.userType;

    SessionRequest* sessionRequest =
        [[SessionRequest alloc] initWithUserName:user password:password appSite:appSite userType:userType];
    [_loginClient createSessionWith:sessionRequest delegate:self];
    [sessionRequest release];
}


/* ================================================================================================================== */
#pragma mark LoginClient delegate

- (void)requestDidFinishWithSessionContext:(SessionContext*)sessionContext {
    LogDebug(@"Request finished. Has error? %@", sessionContext.hasError ? @"YES" : @"NO");
    [_spinner stopAnimating];

    if (sessionContext.hasError) {
        _loginButton.enabled = YES;
        _userNameField.enabled = YES;
        _passwordField.enabled = YES;
        UIAlertView* alert = [[[UIAlertView alloc]
            initWithTitle:@"Error" message:sessionContext.message delegate:self cancelButtonTitle:@"OK"
        otherButtonTitles:nil] autorelease];
        [alert show];
    }
    else {
        [SessionContext setGlobalContext:sessionContext];
        [_navigationManager showMainMenu];
    }
}

- (void)requestDidFailWithError:(NSError*)error {
    [_reporter reportErrorWithReason:@"There was an an unrecoverable system error accessing session data"];
}

/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [_loginClient release];
    [_navigationManager release];
    [_reporter release];
    [_userNameAndPasswordForm release];
    [_loginButton release];
    [_spinner release];
    [_userNameField release];
    [_passwordField release];
    [super dealloc];
}


@end
