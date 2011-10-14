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

SPEC_BEGIN(XmlPostActivityClientIntegration)

describe(@"create activity. . . ", ^{
    
    __block id<expanz_service_ActivityClient> activityClient;
    
    beforeEach(^{
        [IntegrationUtils loginWithDefaultUserIfRequired];
        JSObjectionInjector* injector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]];
        activityClient = [injector getObject:@protocol(expanz_service_ActivityClient)];
    });
    
    it(@"should return activity details upon invocation", ^{
        CreateActivityRequest* activityRequest = [[CreateActivityRequest alloc] 
                                initWithActivityName:@"ESA.Sales.Calc" 
                                sessionToken:[SessionContext globalContext].sessionToken];
        [activityClient createActivityWith:activityRequest delegate:nil];
    });
    
    afterEach(^{
        [activityClient release];
    });
});

SPEC_END