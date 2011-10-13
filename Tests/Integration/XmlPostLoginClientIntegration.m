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


/* ================================================================================================================== */
#pragma mark Call-back methods for request access token. 

@interface TestLoginClientDelegate : NSObject<expanz_service_LoginClientDelegate>

@property (nonatomic, retain) SessionContext* sessionContext;
@property (nonatomic, retain) NSError* error; 

@end

@implementation TestLoginClientDelegate

@synthesize sessionContext = _sessionContext, error = _error;

- (void) requestDidFinishWithSessionContext:(SessionContext*)sessionContext {
    LogDebug(@"Session Token: %@", [sessionContext sessionToken]);
    self.sessionContext = sessionContext;    
}

- (void) requestDidFailWithError:(NSError*)error {
    self.error = error;     
}

@end

/* ================================================================================================================== */
SPEC_BEGIN(XmlPostLoginClientIntegration)


describe(@"Authenticating with the site manager.", ^{
    
    __block XmlPostLoginClient* loginClient; 
    
    beforeEach(^{
        JSObjectionInjector* injector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]];
        loginClient = [injector getObject:@protocol(expanz_service_LoginClient)];
    });
          
        it(@"should return a SessionContext, containing a valid session token, within 5 seconds", ^{
            
            SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                             appSite:@"SALESAPP"]; 
            
            TestLoginClientDelegate* loginDelegate = [[TestLoginClientDelegate alloc] init];
            LogDebug(@"!@@@@@@@@@@@@@@@@@@@@@@ foobar!");
            [loginClient createSessionWith:sessionRequest delegate:loginDelegate];             
            assertWillHappen(loginDelegate.sessionContext != nil);      
            [sessionRequest release];
    });
    
});


SPEC_END