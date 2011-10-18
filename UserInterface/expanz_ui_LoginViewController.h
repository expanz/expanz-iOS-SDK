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

#import <UIKit/UIKit.h>
#import "expanz_service_LoginClient.h"

@interface expanz_ui_LoginViewController : UIViewController
        <expanz_service_LoginClientDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {

@private
    UITextField* _userNameField; 
    UITextField* _passwordField;             
}

@property (nonatomic, readonly) id<expanz_service_LoginClient> loginClient; 
@property (nonatomic, retain) IBOutlet UIBarButtonItem* loginButton; 
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* spinner; 
@property (nonatomic, retain) IBOutlet UITableView* userNameAndPasswordForm; 

/**
 * Initialize using the default nib name, from the main bundle. 
 */
- (id) init; 

/** 
 * Handler that is executed after credentials have been entered.
 */
- (IBAction) loginWithUserNameAndPassword:(id)sender; 


@end


/* ================================================================================================================== */
@compatibility_alias LoginViewController expanz_ui_LoginViewController;
