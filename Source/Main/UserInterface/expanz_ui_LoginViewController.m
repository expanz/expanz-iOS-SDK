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
#import "CAFilter+Unlock.h"

#import "expanz_iOS_SDKAppDelegate.h"
#import "expanz_model_SessionContext.h"
#import "expanz_service_SessionDataRequest.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_ui_LoginViewController.h"
#import "expanz_ui_ActivityMenuViewController.h"
#import "expanz_ui_components_TextFieldTableCell.h"
#import "expanz_iOS_SDKConfiguration.h"

@interface expanz_ui_LoginViewController (private)
- (CATransition*) makeViewTransition;
@end


@implementation expanz_ui_LoginViewController

@synthesize loginClient = _loginClient;
@synthesize loginButton = _loginButton;
@synthesize spinner = _spinner;
@synthesize userNameAndPasswordForm = _userNameAndPasswordForm;

/* ================================================== Constructors ================================================== */

- (id) init {
    self = [super initWithNibName:@"Login" bundle:[NSBundle mainBundle]];
    if (self) {
        _loginClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_LoginClient)];
        [_loginClient retain];
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


- (BOOL) textFieldShouldReturn:(UITextField*)textField {
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

- (void) loginWithUserNameAndPassword:(id)sender {
    _loginButton.enabled = NO;
    _userNameField.enabled = NO;
    _passwordField.enabled = NO;
    [_spinner startAnimating];

    NSString* user = _userNameField.text;
    NSString* password = _passwordField.text;
    NSString* appSite = [SDKConfiguration globalConfiguration].preferredSite;

    SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:user password:password appSite:appSite];
    [_loginClient createSessionWith:sessionRequest delegate:self];
    [sessionRequest release];

}


/* ================================================================================================================== */
#pragma mark LoginClient delegate

- (void) requestDidFinishWithSessionContext:(SessionContext*)sessionContext {
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
        ActivityMenuViewController* menuViewController = [[ActivityMenuViewController alloc] init];

        SessionDataRequest
            * sessionDataRequest = [[SessionDataRequest alloc] initWithSessionToken:sessionContext.sessionToken];
        [menuViewController.sessionDataClient retrieveSessionDataWith:sessionDataRequest delegate:menuViewController];
        [sessionDataRequest release];

        SDKAppDelegate* delegate = [UIApplication sharedApplication].delegate;
        delegate.navigationController =
            [[[UINavigationController alloc] initWithRootViewController:menuViewController] autorelease];
        [menuViewController release];

        [self.view removeFromSuperview];

        [delegate.window.layer addAnimation:[self makeViewTransition] forKey:nil];
        [delegate.window addSubview:delegate.navigationController.view];
        [self release];
    }
}

- (void) requestDidFailWithError:(NSError*)error {
    //TODO: System-wide error handler. 
    UIAlertView* alert = [[[UIAlertView alloc]
        initWithTitle:@"Error" message:@"There was a system error." delegate:self cancelButtonTitle:@"OK"
    otherButtonTitles:nil] autorelease];
    [alert show];

}

/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_loginClient release];
    [_userNameAndPasswordForm release];
    [_loginButton release];
    [_spinner release];
    [_userNameField release];
    [_passwordField release];
    [super dealloc];
}

/* ================================================== Private Methods =============================================== */

//TODO: Private API - replace this with library call. 
- (CATransition*) makeViewTransition {
    static const NSTimeInterval kAnimationDuration = 0.75f;
    CATransition* transition = [CATransition animation];
    transition.duration = kAnimationDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    CAFilter* filter = [CAFilter filterWithName:@"cube"];
    [filter setValue:[NSValue valueWithCGPoint:CGPointMake(160, 240)] forKey:@"inputPosition"];
    transition.filter = filter;
    return transition;
}

@end
