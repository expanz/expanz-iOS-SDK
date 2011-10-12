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
#import "expanz_model_SessionContextHolder.h"
#import "expanz_service_XmlPostLoginClient.h"
#import "Objection.h"
#import "expanz_iOS_SDKModule.h"


/* ================================================================================================================== */
#pragma mark Call-back methods for request access token. 

@interface TestLoginClientDelegate : NSObject<expanz_service_LoginClientDelegate>

@property (nonatomic, retain) SessionContextHolder* sessionContextHolder;
@property (nonatomic, retain) NSError* error; 

@end

@implementation TestLoginClientDelegate

@synthesize sessionContextHolder = _sessionContextHolder, error = _error;

- (void) requestDidFinishWithSessionContext:(SessionContextHolder*)sessionContext {
    LogDebug(@"Session Token: %@", [sessionContext sessionToken]);
    self.sessionContextHolder = sessionContext;    
}

- (void) requestDidFailWithError:(NSError*)error {
    self.error = error;     
}

@end

/* ================================================================================================================== */
SPEC_BEGIN(XmlPostLoginClientSpec)


describe(@"Authenticating with the site manager.", ^{
    
    __block XmlPostLoginClient* loginClient; 
    
    beforeEach(^{
        JSObjectionInjector* injector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]];
        loginClient = [injector getObject:@protocol(expanz_service_LoginClient)];
    });
          
        it(@"should return a SessionContextHolder, containing a valid session token, within 5 seconds", ^{
            
            SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                             appSite:@"SALESAPP"]; 
            
            TestLoginClientDelegate* loginDelegate = [[TestLoginClientDelegate alloc] init];
            [loginClient createSessionWith:sessionRequest delegate:loginDelegate]; 
            
            [NSThread sleepForTimeInterval:5];
            LogDebug(@"Result: %@", [loginDelegate sessionContextHolder]);
            assertThat([loginDelegate sessionContextHolder], isNot(nil));
            [sessionRequest release];
    });
    
});


SPEC_END