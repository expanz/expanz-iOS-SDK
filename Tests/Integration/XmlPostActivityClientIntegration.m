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
#import "expanz_iOS_SDKModule.h"
#import "expanz_service_ActivityClient.h"
#import "expanz_service_CreateActivityRequest.h"
#import "IntegrationUtils.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_service_XmlPostActivityClient.h"

/* ================================================================================================================== */
@interface TestCreateActivityClientDelegate : NSObject<expanz_service_CreateActivityClientDelegate> 
    
@property (nonatomic, retain) ActivityInstance* activityInstance; 
@property (nonatomic, retain) NSError* error; 
    
@end

@implementation TestCreateActivityClientDelegate

@synthesize activityInstance = _activityInstance, error = _error;

- (void) requestDidFinishWithActivityInstance:(ActivityInstance*)activityInstance {
    _activityInstance = [activityInstance retain]; 
}

- (void) requestDidFailWithError:(NSError*)error {
    _error = [error retain];
}

- (void) dealloc {
    [_activityInstance release]; 
    [_error release]; 
    [super dealloc]; 
}

@end


/* ================================================================================================================== */
SPEC_BEGIN(XmlPostActivityClientIntegration)

__block id<expanz_service_ActivityClient> activityClient;
__block TestCreateActivityClientDelegate* delegate;

beforeEach(^{
    [IntegrationUtils loginWithDefaultUserIfRequired];
    JSObjectionInjector* injector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]];
    activityClient = [injector getObject:@protocol(expanz_service_ActivityClient)];
    delegate = [[[TestCreateActivityClientDelegate alloc] init] autorelease];        
});


describe(@"create activity. . . ", ^{
        
    it(@"should return activity details upon invocation", ^{
        CreateActivityRequest* activityRequest = [[[CreateActivityRequest alloc] 
                                initWithActivityName:@"ESA.Sales.Calc" 
                                sessionToken:[SessionContext globalContext].sessionToken] autorelease];
        
        [activityClient createActivityWith:activityRequest delegate:delegate];
        assertWillHappen(delegate.activityInstance != nil); 
    });
    
});

describe(@"Error handling", ^{
    it(@"should invoke the delegate's error handler, if the underlying ASIFormDataRequest fails.", ^{
        CreateActivityRequest* activityRequest = [[[CreateActivityRequest alloc] 
                                                   initWithActivityName:@"ESA.Sales.Calc" 
                                                   sessionToken:[SessionContext globalContext].sessionToken] 
                                                   autorelease];
        
        ASIFormDataRequest* requestThatWillFail = [IntegrationUtils requestThatWillFail]; 
        id<expanz_service_ActivityClient> anotherClient = [[XmlPostActivityClient alloc] 
                                                            initWithRequest:requestThatWillFail];
        [anotherClient createActivityWith:activityRequest delegate:delegate]; 
        assertWillHappen(delegate.error != nil);
        LogDebug(@"Error %@", delegate.error);
    });
});


SPEC_END