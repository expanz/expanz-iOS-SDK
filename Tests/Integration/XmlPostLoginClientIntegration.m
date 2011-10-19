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
#import "expanz_model_SessionContext.h"
#import "expanz_service_XmlPostLoginClient.h"
#import "Objection.h"
#import "expanz_iOS_SDKModule.h"
#import "TestLoginClientDelegate.h"
#import "IntegrationUtils.h"


SPEC_BEGIN(XmlPostLoginClientIntegration)


describe(@"Authenticating with the site manager.", ^{
    
    __block XmlPostLoginClient* loginClient; 
    __block TestLoginClientDelegate* loginDelegate; 
    
    beforeEach(^{
        JSObjectionInjector* injector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]];
        loginClient = [injector getObject:@protocol(expanz_service_LoginClient)];
        loginDelegate = [[TestLoginClientDelegate alloc] init];    
    });
          
    it(@"should return a SessionContext, containing a valid session token, within 5 seconds", ^{
            
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                          appSite:@"SALESAPP"];
            
        [loginClient createSessionWith:sessionRequest delegate:loginDelegate];                 
        [sessionRequest release];
        assertWillHappen(loginDelegate.sessionContext != nil);              
    });
    
    it(@"should invoke the delegates requestDidFail method if the underlying ASIFormDataRequest fails.", ^{
        ASIFormDataRequest* requestThatWillFail = [IntegrationUtils requestThatWillFail]; 
        XmlPostLoginClient* anotherLoginClient = [[XmlPostLoginClient alloc] initWithRequest:requestThatWillFail];
        [anotherLoginClient createSessionWith:nil delegate:loginDelegate];    
        assertWillHappen(loginDelegate.error != nil);
        [anotherLoginClient release];
    });    
    
    afterEach(^{
        [loginDelegate release];
    });
});


SPEC_END