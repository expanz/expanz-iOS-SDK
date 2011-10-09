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
#import "expanz_service_XmlPostSessionDataClient.h"
#import "expanz_iOS_SDKModule.h"
#import "expanz_service_SessionDataRequest.h"

/* ================================================================================================================== */
#pragma mark Call back methods for XmlPostSessionDataClient

@interface TestSessionDataClientDelegate : NSObject<expanz_service_SessionDataDelegate> 


@end

@implementation TestSessionDataClientDelegate 

- (void) requestDidFinishWithSessionContext:(id)holder {

    
}

- (void) requestDidFailWithError:(NSError*)error {
    
}

@end


/* ================================================================================================================== */
SPEC_BEGIN(XmlPostSessionDataClientSpec)

describe(@"Retrieve session data using an access token", ^{
    
    __block id<expanz_service_SessionDataClient> sessionDataClient; 
    
    beforeEach(^{
        JSObjectionInjector* injector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]];
        sessionDataClient = [injector getObject:@protocol(expanz_service_SessionDataClient)];
    });
    
    it(@"should retrieve session data", ^{
        TestSessionDataClientDelegate* delegate = [[[TestSessionDataClientDelegate alloc] init] autorelease];
        NSString* token = @"net.tcp://127.0.0.1:8198/SessionManager1#634536054150607978:291";
        SessionDataRequest* request = [[SessionDataRequest alloc] initWithSessionToken:token];
        [sessionDataClient retrieveSessionDataWith:request delegate:delegate];  
        [request release];        
        [NSThread sleepForTimeInterval:5];
    });
});




SPEC_END