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

#import "Objection.h"
#import "IntegrationUtils.h"
#import "ExpanzLoginClient.h"
#import "StubLoginClientDelegate.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_UserInterfaceModule.h"
#import "expanz_service_CreateActivityRequest.h"
#import "ExpanzActivityClient.h"
#import "StubActivityClientDelegate.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_SessionContext.h"
#import "expanz_SdkConfiguration.h"


@implementation IntegrationUtils

+ (void) useDefaultBackendForIntegrationTests {
    SdkConfiguration* configuration = [[SdkConfiguration alloc]
        initWithBaseUrl:@"http://test.expanz.com/ESADemoService/ESAService.svc/restish" preferredSite:@"SALES"
               userType:@"Primary"];
    [SdkConfiguration clearGlobalConfiguration];
    [SdkConfiguration setGlobalConfiguration:configuration];
}


+ (void) loginWithDefaultUserIfRequired {

    if ([SessionContext globalContext] == nil) {
        JSObjectionInjector* testInjector = [JSObjection createInjector:[[UserInterfaceModule alloc] init]];

        id<ExpanzLoginClient> loginClient = [testInjector getObject:@protocol(ExpanzLoginClient)];
        SessionRequest* sessionRequest =
            [[SessionRequest alloc] initWithUserName:@"demo4" password:@"demo" appSite:@"SALES" userType:@"Alternate"];
        StubLoginClientDelegate* loginDelegate = [[StubLoginClientDelegate alloc] init];
        [loginClient createSessionWith:sessionRequest delegate:loginDelegate];
        assertWillHappen(loginDelegate.sessionContext != nil);
        [SessionContext setGlobalContext:loginDelegate.sessionContext];
    }LogDebug(@"Global session token is now: %@", [SessionContext globalContext].sessionToken);
}

+ (ActivityInstance*) aValidActivity {
    JSObjectionInjector* testInjector = [JSObjection createInjector:[[UserInterfaceModule alloc] init]];
    CreateActivityRequest* activityRequest = [[CreateActivityRequest alloc]
        initWithActivityName:@"Sales.Customer" style:[ActivityStyle browseStyle] initialKey:nil
                sessionToken:[SessionContext globalContext].sessionToken];

    id<ExpanzActivityClient>
        activityClient = [testInjector getObject:@protocol(ExpanzActivityClient)];

    StubActivityClientDelegate* delegate = [[StubActivityClientDelegate alloc] init];

    [activityClient createActivityWith:activityRequest delegate:delegate];
    assertWillHappen(delegate.activityInstance != nil);
    return delegate.activityInstance;
}


@end
