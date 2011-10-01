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
#import "JBPackageVoodoo.h"
#import "ex_security_LoginClient.h"

@interface expanz_ui_LoginViewController : UIViewController<ex_security_LoginClientDelegate> {

@private
    UITextField* _fieldWithCurrentFocus; 
        
}

@property (nonatomic, readonly) id<ex_security_LoginClient> loginClient; 
@property (nonatomic, readonly) IBOutlet UITextField* userName;
@property (nonatomic, readonly) IBOutlet UITextField* password;
@property (nonatomic, readonly) IBOutlet UIButton* loginButton; 
@property (nonatomic, readonly) IBOutlet UIActivityIndicatorView* spinner; 

- (IBAction) loginWithUserNameAndPassword:(id)sender; 


@end
