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

#import "IntegrationUtils.h"
#import "expanz_service_LoginClient.h" 
#import "TestLoginClientDelegate.h"
#import "expanz_service_SessionRequest.h"
#import "Objection.h"
#import "expanz_iOS_SDKModule.h"
#import "expanz_service_SessionRequest.h"
#import "SpecHelper.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_ActivityClient.h"
#import "TestActivityClientDelegate.h"
#import "expanz_model_ActivityInstance.h"


@implementation IntegrationUtils



+ (void) loginWithDefaultUserIfRequired {
    if ([SessionContext globalContext] == nil) {
        JSObjectionInjector* testInjector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]]; 
        
        id<expanz_service_LoginClient> loginClient = [testInjector getObject:@protocol(expanz_service_LoginClient)]; 
        SessionRequest* sessionRequest = [[[SessionRequest alloc] initWithUserName:@"demo4" password:@"demo" 
                                                                           appSite:@"SALESAPP"] autorelease]; 
        TestLoginClientDelegate* loginDelegate = [[TestLoginClientDelegate alloc] init]; 
        [loginClient createSessionWith:sessionRequest delegate:loginDelegate]; 
        assertWillHappen(loginDelegate.sessionContext != nil); 
        [SessionContext setGlobalContext:loginDelegate.sessionContext];
    }
    LogDebug(@"Global session context is: %@", [SessionContext globalContext]);
}

+ (NSString*) aValidActivityHandle {
    JSObjectionInjector* testInjector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]]; 
    CreateActivityRequest* activityRequest = [[CreateActivityRequest alloc] 
                                               initWithActivityName:@"ESA.Sales.Calc" 
                                               sessionToken:[SessionContext globalContext].sessionToken];
    
    id<expanz_service_ActivityClient> activityClient = [testInjector 
                                                        getObject:@protocol(expanz_service_ActivityClient)];
    
    TestActivityClientDelegate* delegate = [[TestActivityClientDelegate alloc] init];
    
    [activityClient createActivityWith:activityRequest delegate:delegate];
    assertWillHappen(delegate.activityInstance != nil);
    NSString* handle = [[[NSString alloc] initWithString:delegate.activityInstance.handle] autorelease];
    [delegate release];
    return handle;
}

+ (ASIFormDataRequest*) requestThatWillFail {
    NSURL* url = [NSURL URLWithString:@"hhhhhtp:/bad.url"];
    return [ASIFormDataRequest requestWithURL:url];
}


@end
