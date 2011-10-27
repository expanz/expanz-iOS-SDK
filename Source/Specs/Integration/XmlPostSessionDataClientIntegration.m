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
#import "Objection.h"
#import "expanz_service_SessionDataClient.h"
#import "IntegrationUtils.h"
#import "expanz_model_SessionContext.h"
#import "expanz_model_Menu.h"
#import "expanz_service_SessionDataRequest.h"
#import "expanz_service_XmlPostSessionDataClient.h"

/* ================================================================================================================== */
#pragma mark Call back methods for XmlPostSessionDataClient

@interface TestSessionDataClientDelegate : NSObject<expanz_service_SessionDataClientDelegate> 

@property (nonatomic, readonly) Menu* menu;
@property (nonatomic, readonly) NSError* error; 

@end

@implementation TestSessionDataClientDelegate 

@synthesize menu = _menu;
@synthesize error = _error;

- (void) requestDidFinishWithMenu:(Menu*)menu {
    _menu = [menu retain];    
}

- (void) requestDidFailWithError:(NSError*)error {
    _error = [error retain];
    
}

- (void) dealloc {
    [_menu release]; 
    [super dealloc];
}

@end


/* ================================================================================================================== */
SPEC_BEGIN(XmlPostSessionDataClientIntegration)

describe(@"Retrieve session data using an access token", ^{
    
    __block id<expanz_service_SessionDataClient> sessionDataClient; 
    __block TestSessionDataClientDelegate* delegate; 
    
    beforeEach(^{
        [IntegrationUtils loginWithDefaultUserIfRequired];        
        JSObjectionInjector* injector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]];
        sessionDataClient = [injector getObject:@protocol(expanz_service_SessionDataClient)];
        delegate = [[[TestSessionDataClientDelegate alloc] init] autorelease];
    });
    
    it(@"should retrieve session data", ^{
        NSString* sessionToken = [SessionContext globalContext].sessionToken; 
        SessionDataRequest* request = [[SessionDataRequest alloc] initWithSessionToken:sessionToken]; 
        [sessionDataClient retrieveSessionDataWith:request delegate:delegate];  
        [request release];        
        assertWillHappen(delegate.menu != nil); 
        LogDebug("Request finished with: %@", delegate.menu);        
    });
    
    it(@"should invoke the delegate's failure handler if the underlying ASIFormDataRequest fails.", ^{
        XmlPostSessionDataClient* anotherClient = [[[XmlPostSessionDataClient alloc] 
                                                   initWithRequest:[IntegrationUtils requestThatWillFail]] autorelease]; 
        [anotherClient retrieveSessionDataWith:nil delegate:delegate]; 
        assertWillHappen(delegate.error != nil); 
        LogDebug(@"Error: %@", delegate.error);
    });
        
});




SPEC_END