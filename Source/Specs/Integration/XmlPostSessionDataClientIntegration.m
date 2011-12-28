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
#import "expanz_service_SessionDataClient.h"
#import "IntegrationUtils.h"
#import "expanz_service_SessionDataRequest.h"
#import "expanz_service_SessionDataClientDelegate.h"
#import "expanz_model_Menu.h"
#import "expanz_service_XmlPostSessionDataClient.h"

/* ================================================================================================================== */
#pragma mark Call back methods for XmlPostSessionDataClient

@interface TestSessionDataClientDelegate : NSObject<expanz_service_SessionDataClientDelegate> 

@property (nonatomic, strong, readonly) Menu* menu;
@property (nonatomic, strong, readonly) NSError* error;

@end

@implementation TestSessionDataClientDelegate 

@synthesize menu = _menu;
@synthesize error = _error;

- (void) requestDidFinishWithMenu:(Menu*)menu {
    _menu = menu;
}

- (void) requestDidFailWithError:(NSError*)error {
    _error = error;
    
}

@end


/* ================================================================================================================== */
SPEC_BEGIN(XmlPostSessionDataClientIntegration)

describe(@"Retrieve session data using an access token", ^{
    
    __block id<expanz_service_SessionDataClient> sessionDataClient; 
    __block TestSessionDataClientDelegate* delegate; 
    
    beforeEach(^{
        [IntegrationUtils loginWithDefaultUserIfRequired];        
        JSObjectionInjector* injector = [JSObjection createInjector:[[SDKModule alloc] init]];
        sessionDataClient = [injector getObject:@protocol(expanz_service_SessionDataClient)];
        delegate = [[TestSessionDataClientDelegate alloc] init];
    });
    
    it(@"should retrieve session data", ^{
        NSString* sessionToken = [SessionContext globalContext].sessionToken; 
        SessionDataRequest* request = [[SessionDataRequest alloc] initWithSessionToken:sessionToken]; 
        [sessionDataClient retrieveSessionDataWith:request delegate:delegate];
        assertWillHappen(delegate.menu != nil); 
        LogDebug("Request finished with: %@", delegate.menu);        
    });
    
    it(@"should invoke the delegate's failure handler if the underlying ASIFormDataRequest fails.", ^{
        XmlPostSessionDataClient* anotherClient = [[XmlPostSessionDataClient alloc]
                                                   initWithServiceUrl:[IntegrationUtils urlThatWillFail]];
        [anotherClient retrieveSessionDataWith:nil delegate:delegate]; 
        assertWillHappen(delegate.error != nil); 
        LogDebug(@"Error: %@", delegate.error);
    });
        
});




SPEC_END