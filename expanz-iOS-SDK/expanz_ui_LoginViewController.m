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

#import <QuartzCore/QuartzCore.h>
#import "JBPackageVoodoo.h"


@implementation expanz_ui_LoginViewController

@synthesize loginClient = _loginClient; 
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize loginButton = _loginButton;
@synthesize spinner = _spinner; 

/* ================================================== Constructors ================================================== */
- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _loginClient = [[JSObjection globalInjector] getObject:@protocol(ex_security_LoginClient)];
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void) viewDidLoad
{
    [super viewDidLoad];
}
*/

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
#pragma mark User Actions

- (void) loginWithUserNameAndPassword:(id)sender {
    
    if (_userName.text.length > 0 && _password.text.length > 0) {
        _loginButton.enabled = NO;
        [_spinner startAnimating];
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:_userName.text password:_password.text 
                                                                          appSite:@"SALESAPP"];        
        [_loginClient createSessionWith:sessionRequest delegate:self];        
    }    
}

- (void) textFieldDidBeginEditing:(UITextField*)textField {
    _fieldWithCurrentFocus = textField;
}


-(BOOL) textFieldShouldReturn:(UITextField*) textField {
    [_fieldWithCurrentFocus resignFirstResponder];
    [self loginWithUserNameAndPassword:nil];
    return YES;
}


/* ================================================================================================================== */
#pragma mark LoginClient delegate

- (void) requestDidFinishWithSessionContext:(SessionContextHolder*)sessionContext {
    LogDebug(@"Request finished. Has error? %@", sessionContext.hasError ? @"YES" : @"NO");
    [_spinner stopAnimating];
    
    if (!sessionContext.hasError) {

        ActivityViewController* activityViewController = [[ActivityViewController alloc] 
                                                        initWithNibName: @"ActivityWindow" 
                                                        bundle: [NSBundle mainBundle]];        
 
        static const NSTimeInterval kAnimationDuration = 0.75f;
        CATransition* transition = [CATransition animation];
        transition.duration = kAnimationDuration;
        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        transition.subtype = kCATransitionFromRight;
        transition.delegate = self;
        CAFilter* filter = [CAFilter filterWithName:@"cube"];
        [filter setValue:[NSValue valueWithCGPoint:CGPointMake(160, 240)] forKey:@"inputPosition"];
        transition.filter = filter;
               
        [self.navigationController.view.layer addAnimation:transition forKey:nil];    
        [self.navigationController pushViewController: activityViewController animated:NO];

    }
    else {
        _loginButton.enabled = YES;
        UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Error" message:sessionContext.errorMessage 
                                                        delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] 
                                                        autorelease];
        [alert show];
    }    
}

- (void) requestDidFailWithError:(NSError*)error {
    
}

/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_userName dealloc];
    [_password dealloc];
    [super dealloc];
}

@end
