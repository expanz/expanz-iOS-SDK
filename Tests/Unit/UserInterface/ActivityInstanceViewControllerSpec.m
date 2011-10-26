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
#import "MARTNSObject.h"
#import "RTProtocol.h"
#import "RTIvar.h"
#import "RTProperty.h"
#import "RTMethod.h"
#import "RTUnregisteredClass.h"
#import "expanz_ui_ActivityInstanceViewController.h"


SPEC_BEGIN(ActivityInstanceViewControllerSpec)

describe(@"objc runtime. . . ", ^{
    
    
    it(@"can i instantiate a class using class name?", ^{

        id clazz = objc_getClass("expanz_ui_BasicCalculatorViewController");
        //assertThat(clazz, notNilValue());
        LogDebug(@"%@", [clazz description]);

        ActivityInstanceViewController* controller = class_createInstance(clazz, 0);
        //assertThat(controller, notNilValue());



    });
    
});

SPEC_END