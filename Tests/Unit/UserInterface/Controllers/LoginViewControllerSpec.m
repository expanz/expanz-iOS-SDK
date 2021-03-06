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

#import "expanz_ui_LoginViewController.h"
#import "JSObjectionInjector.h"
#import "JSObjection.h"
#import "expanz_UserInterfaceModule.h"

SPEC_BEGIN(LoginViewControllerSpec)

describe(@"Object creation", ^{
    
    
    beforeEach(^{
        JSObjectionInjector* injector = [JSObjection createInjector:[[UserInterfaceModule alloc] init]];
        [JSObjection setGlobalInjector:injector];
    });
    
    it(@"should provide a default initializer that loads the default nib from the main bundle.", ^{
        LoginViewController* loginController = [[LoginViewController alloc] init];
        [loginController shouldNotBeNil];
        [loginController.view shouldNotBeNil];

        [theValue([loginController loginClient]) shouldNotBeNil];

        [loginController.loginButton shouldNotBeNil];
        [loginController.spinner shouldNotBeNil];
        [loginController.userNameAndPasswordForm shouldNotBeNil];
    });
    
});


SPEC_END