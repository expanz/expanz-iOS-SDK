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


@implementation IntegrationUtils


+ (void) loginWithDefaultUserIfRequired {
    if ([SessionContext globalContext] == nil) {
        JSObjectionInjector* loginInjector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]]; 
        id<expanz_service_LoginClient> loginClient = [loginInjector getObject:@protocol(expanz_service_LoginClient)]; 
        SessionRequest* sessionRequest = [[[SessionRequest alloc] initWithUserName:@"demo4" password:@"demo" 
                                                                           appSite:@"SALESAPP"] autorelease]; 
        TestLoginClientDelegate* loginDelegate = [[TestLoginClientDelegate alloc] init]; 
        [loginClient createSessionWith:sessionRequest delegate:loginDelegate]; 
        assertWillHappen(loginDelegate.sessionContext != nil); 
        [SessionContext setGlobalContext:loginDelegate.sessionContext];
    }
    LogDebug(@"Global session context is: %@", [SessionContext globalContext]);
}

+ (ASIFormDataRequest*) requestThatWillFail {
    NSURL* url = [NSURL URLWithString:@"hhhhhtp:/bad.url"];
    return [ASIFormDataRequest requestWithURL:url];
}


@end
