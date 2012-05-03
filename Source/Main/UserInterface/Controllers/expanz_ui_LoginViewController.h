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
#import "ExpanzLoginClient.h"
#import "expanz_ui_components_TextFieldTableCell.h"

@class expanz_ui_NavigationManager;
@protocol expanz_ui_SystemEventReporter;

@interface expanz_ui_LoginViewController : UIViewController
        <ExpanzLoginClientDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {

@private
    expanz_ui_NavigationManager* _navigationManager;
    id<expanz_ui_SystemEventReporter> _reporter;
}

@property(nonatomic, strong) id<ExpanzLoginClient> loginClient;
@property(nonatomic, weak) IBOutlet UIBarButtonItem* loginButton;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView* spinner;
@property(nonatomic, weak) IBOutlet UITableView* userNameAndPasswordForm;
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
