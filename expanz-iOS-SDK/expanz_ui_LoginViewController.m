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

#import "JBPackageVoodoo.h"

@implementation expanz_ui_LoginViewController

@synthesize loginClient = _loginClient; 
@synthesize userName = _userName;
@synthesize password = _password;

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

- (void) userDidRequestLogin:(id)sender {
    
    if (_userName.text.length > 0 && _password.text.length > 0) {
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:_userName.text password:_password.text 
                                                                          appSite:@"SALESAPP"];        
        [_loginClient createSessionWith:sessionRequest delegate:self];        
    }    
}

-(BOOL) textFieldShouldReturn:(UITextField*) textField {
    [self userDidRequestLogin:nil];
    [textField resignFirstResponder]; 
    return YES;
}


/* ================================================================================================================== */
#pragma mark LoginClient delegate

- (void) requestDidFinishWithSessionContext:(SessionContextHolder*)sessionContext {
    
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
