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
#import "expanz_service_LoginClient.h" 
#import "StubLoginClientDelegate.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_iOS_SDKModule.h"
#import "expanz_service_SessionRequest.h"
#import "SpecHelper.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_ActivityClient.h"
#import "StubActivityClientDelegate.h"
#import "expanz_model_ActivityInstance.h"


@implementation IntegrationUtils

+ (void) loginWithDefaultUserIfRequired {
    if ([SessionContext globalContext] == nil) {
        JSObjectionInjector* testInjector = [JSObjection createInjector:[[SDKModule alloc] init]];
        
        id<expanz_service_LoginClient> loginClient = [testInjector getObject:@protocol(expanz_service_LoginClient)]; 
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo4" password:@"demo"
                                                                appSite:@"SALESAPP" userType:@"Primary"];
        StubLoginClientDelegate* loginDelegate = [[StubLoginClientDelegate alloc] init];
        [loginClient createSessionWith:sessionRequest delegate:loginDelegate]; 
        assertWillHappen(loginDelegate.sessionContext != nil); 
        [SessionContext setGlobalContext:loginDelegate.sessionContext];
    }
    LogDebug(@"Global session context is: %@", [SessionContext globalContext]);
}

+ (ActivityInstance*) aValidActivity {
    JSObjectionInjector* testInjector = [JSObjection createInjector:[[SDKModule alloc] init]];
    CreateActivityRequest* activityRequest = [[CreateActivityRequest alloc] initWithActivityName:@"ESA.Sales.Calc" 
                style:[ActivityStyle browseStyle] initialKey:nil sessionToken:[SessionContext globalContext].sessionToken];
    
    id<expanz_service_ActivityClient> activityClient = [testInjector 
                                                        getObject:@protocol(expanz_service_ActivityClient)];
    
    StubActivityClientDelegate* delegate = [[StubActivityClientDelegate alloc] init];
    
    [activityClient createActivityWith:activityRequest delegate:delegate];
    assertWillHappen(delegate.activityInstance != nil);
    return delegate.activityInstance;
}

+ (NSURL*)urlThatWillFail {
    return [NSURL URLWithString:@"hhhhhtp:/bad.url"];
}


@end
