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

#import "SpecHelper.h" 
#import "expanz_ui_LoginViewController.h"

SPEC_BEGIN(LoginViewControllerSpec)

describe(@"Object creation", ^{
    
    it(@"should provide a default initializer that loads the default nib from the main bundle.", ^{
        LoginViewController* loginController = [[[LoginViewController alloc] init] autorelease]; 
        assertThat(loginController, notNilValue());
    });

    
});

SPEC_END