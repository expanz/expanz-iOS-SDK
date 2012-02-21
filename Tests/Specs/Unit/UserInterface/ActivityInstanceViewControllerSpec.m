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


#import <objc/runtime.h>

SPEC_BEGIN(ActivityInstanceViewControllerSpec)

describe(@"objc runtime. . . ", ^{
    
    
    it(@"can i instantiate a class using class name?", ^{

        id clazz = objc_getClass("expanz_ui_BasicCalculatorViewController");
        //assertThat(clazz, notNilValue());
        LogDebug(@"%@", [clazz description]);

        //ActivityInstanceViewController* controller = class_createInstance(clazz, 0);
        //assertThat(controller, notNilValue());

    });


    it(@"can i use NSValue to store a pointer to an object, to use as a key in a dictionary?", ^{
        UITableView* tableView = [[UITableView alloc] init];
        NSValue* value = [NSValue valueWithPointer:(__bridge void*) tableView];
        LogDebug(@"Address: %@", value);



    });
});

SPEC_END