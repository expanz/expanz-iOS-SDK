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
#import "ExpanzSessionDataClient.h"
#import "IntegrationUtils.h"
#import "expanz_service_SessionDataRequest.h"
#import "expanz_model_Menu.h"
#import "expanz_service_DefaultSessionDataClient.h"
#import "expanz_UserInterfaceModule.h"
#import "expanz_model_SessionContext.h"
#import "expanz_model_SessionData.h"

/* ================================================================================================================== */
#pragma mark Call back methods for XmlPostSessionDataClient

@interface TestSessionDataClientDelegate : NSObject<ExpanzSessionDataClientDelegate>

@property (nonatomic, strong, readonly) Menu* menu;
@property (nonatomic, strong, readonly) NSError* error;

@end

@implementation TestSessionDataClientDelegate 

@synthesize menu = _menu;
@synthesize error = _error;

- (void) requestDidFinishWithSessionData:(expanz_model_SessionData*)sessionData {
    _menu = sessionData.menu;
}

- (void) requestDidFailWithError:(NSError*)error {
    _error = error;
    
}

@end


/* ================================================================================================================== */
SPEC_BEGIN(DefaultSessionDataClientIntegration)

describe(@"Retrieve session data using an access token", ^{
    
    __block id<ExpanzSessionDataClient> sessionDataClient;
    __block TestSessionDataClientDelegate* delegate; 
    
    beforeEach(^{
        [IntegrationUtils useDefaultBackendForIntegrationTests];
        [IntegrationUtils loginWithDefaultUserIfRequired];        
        JSObjectionInjector* injector = [JSObjection createInjector:[[UserInterfaceModule alloc] init]];
        sessionDataClient = [injector getObject:@protocol(ExpanzSessionDataClient)];
        delegate = [[TestSessionDataClientDelegate alloc] init];
    });
    
    it(@"should retrieve session data", ^{
        NSString* sessionToken = [SessionContext globalContext].sessionToken;
        LogDebug(@"Here's the sessionToken: %@", sessionToken);
        SessionDataRequest* request = [[SessionDataRequest alloc] initWithSessionToken:sessionToken]; 
        [sessionDataClient retrieveSessionDataWith:request delegate:delegate];
        [[expectFutureValue(delegate.menu) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
        LogDebug("Request finished with: %@", delegate.menu);        
    });

        
});




SPEC_END