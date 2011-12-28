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
#import "expanz_iOS_SDKAppDelegate.h"
#import "OCMockObject.h"
#import "OCMArg.h"


SPEC_BEGIN(SDKAppDelegateSpec)

    __block SDKAppDelegate* delegate;

    beforeEach(^{
        delegate = [[SDKAppDelegate alloc] init];
    });

    describe(@"Object creation & configuration", ^{

        it(@"should allow configuration with window and navigationController properties", ^{

            delegate.window = [[UIWindow alloc] init];
            delegate.navigationController = [[UINavigationController alloc] init];

            assertThat(delegate.window, notNilValue());
            assertThat(delegate.navigationController, notNilValue());
        });

    });

    describe(@"Lifecycle", ^{

        it(@"should instantiate and show the application window after launching.", ^{
            id window = [OCMockObject mockForClass:[UIWindow class]];
            [[window expect] addSubview:[OCMArg any]];
            [[window expect] makeKeyAndVisible];
            
            delegate.window = window;
            UIApplication* application = [OCMockObject niceMockForClass:[UIApplication class]];
            [delegate application:application didFinishLaunchingWithOptions:nil];
            
            [window verify];
        });

    });


    SPEC_END