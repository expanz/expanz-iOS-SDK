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
#import "SpecHelper.h"
#import "expanz_model_SessionContext.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_service_XmlPostLoginClient.h"
#import "expanz_iOS_SDKModule.h"
#import "StubLoginClientDelegate.h"
#import "IntegrationUtils.h"


SPEC_BEGIN(XmlPostLoginClientIntegration)


describe(@"Authenticating with the site manager.", ^{
    
    __block XmlPostLoginClient* loginClient; 
    __block StubLoginClientDelegate* loginDelegate;
    
    beforeEach(^{
        JSObjectionInjector* injector = [JSObjection createInjector:[[SDKModule alloc] init]];
        loginClient = [injector getObject:@protocol(expanz_service_LoginClient)];
        loginDelegate = [[StubLoginClientDelegate alloc] init];
    });
          
    it(@"should return a SessionContext, containing a valid session token, within 5 seconds", ^{
            
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                          appSite:@"SALES" userType:@"Primpary"];
            
        [loginClient createSessionWith:sessionRequest delegate:loginDelegate];
        assertWillHappen(loginDelegate.sessionContext.sessionToken != nil);
    });
    

});


SPEC_END