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


SPEC_BEGIN(SDKAppDelegateSpec)

    __block SDKAppDelegate* delegate;

    beforeEach(^{
        delegate = [[[SDKAppDelegate alloc] init] autorelease];
    });

    describe(@"Object creation & configuration", ^{

        it(@"should allow configuration with window and navigationController properties", ^{

            delegate.window = [[[UIWindow alloc] init] autorelease];
            delegate.navigationController = [[[UINavigationController alloc] init] autorelease];

            assertThat(delegate.window, notNilValue());
            assertThat(delegate.navigationController, notNilValue());
        });

    });


    SPEC_END