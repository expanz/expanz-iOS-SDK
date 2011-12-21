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

@class expanz_ui_NavigationManager;
@protocol expanz_ui_SystemEventReporter;

@interface expanz_ui_LoginViewController : UIViewController
        <expanz_service_LoginClientDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {

@private
    CGFloat _animatedDistance;
    BOOL _scrolled;
    UITextField* _userNameField; 
    UITextField* _passwordField;
    expanz_ui_NavigationManager* _navigationManager;
    id<expanz_ui_SystemEventReporter> _reporter;
}

@property(nonatomic, strong) id<expanz_service_LoginClient> loginClient;
@property(nonatomic, strong) IBOutlet UIBarButtonItem* loginButton;
@property(nonatomic, strong) IBOutlet UIActivityIndicatorView* spinner;
@property(nonatomic, strong) IBOutlet UITableView* userNameAndPasswordForm;

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
