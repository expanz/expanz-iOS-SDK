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
#import "expanz_ui_components_TextFieldTableCell.h"

@class expanz_ui_NavigationManager;
@protocol expanz_ui_SystemEventReporter;

@interface expanz_ui_LoginViewController : UIViewController
        <expanz_service_LoginClientDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {

@private
    expanz_ui_NavigationManager* _navigationManager;
    id<expanz_ui_SystemEventReporter> _reporter;
}

@property(nonatomic, strong) id<expanz_service_LoginClient> loginClient;
@property(nonatomic, strong) IBOutlet UIBarButtonItem* loginButton;
@property(nonatomic, strong) IBOutlet UIActivityIndicatorView* spinner;
@property(nonatomic, strong) IBOutlet UITableView* userNameAndPasswordForm;
@property(nonatomic, strong) IBOutlet expanz_ui_components_TextFieldTableCell* userNameCell;
@property(nonatomic, strong) IBOutlet expanz_ui_components_TextFieldTableCell* passwordCell;


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
