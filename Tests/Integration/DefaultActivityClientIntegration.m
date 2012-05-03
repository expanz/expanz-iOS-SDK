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

#import "StubActivityClientDelegate.h"
#import "IntegrationUtils.h"
#import "expanz_UserInterfaceModule.h"
#import "ExpanzActivityClient.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_service_DefaultActivityClient.h"
#import "expanz_service_DeltaRequest.h"
#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_service_FileRequest.h"
#import "expanz_model_SessionContext.h"
#import "expanz_SdkConfiguration.h"

SPEC_BEGIN(DefaultActivityClientIntegration)


    __block id<ExpanzActivityClient> activityClient;
    __block StubActivityClientDelegate* delegate;

    beforeEach(^{
        [IntegrationUtils useDefaultBackendForIntegrationTests];
        [IntegrationUtils loginWithDefaultUserIfRequired];
        JSObjectionInjector* injector = [JSObjection createInjector:[[UserInterfaceModule alloc] init]];
        activityClient = [injector getObject:@protocol(ExpanzActivityClient)];
        delegate = [[StubActivityClientDelegate alloc] init];
    });


    describe(@"create activity. . . ", ^{

        it(@"should return activity details upon invocation", ^{
            CreateActivityRequest* activityRequest = [[CreateActivityRequest alloc]
                initWithActivityName:@"Sales.Customer" style:[ActivityStyle defaultStyle] initialKey:nil
                        sessionToken:[SessionContext globalContext].sessionToken];

            [activityClient createActivityWith:activityRequest delegate:delegate];
            [[expectFutureValue(delegate.activityInstance) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
        });


    });

    describe(@"sending deltas", ^{

        it(@"should allow sending updated field values", ^{

            NSString* activityHandle = [IntegrationUtils aValidActivity].handle;
            LogDebug(@"Activity handle: %@", activityHandle);
            DeltaRequest* deltaRequest = [[DeltaRequest alloc]
                initWithFieldId:@"FirstName" fieldValue:@"Jasper" activityHandle:activityHandle
                   sessionToken:[SessionContext globalContext].sessionToken];
            LogDebug(@"%@", [deltaRequest toXml]);
            [activityClient sendDeltaWith:deltaRequest delegate:delegate];

            [[expectFutureValue(delegate.activityInstance) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
            LogDebug(@"%@", delegate.activityInstance);
        });
    });

    describe(@"server method invocations.", ^{

        it(@"should allow sending invoking methods on the server-side model.", ^{
            ActivityInstance* activityInstance = [IntegrationUtils aValidActivity];
            MethodInvocationRequest* methodRequest =
                [[MethodInvocationRequest alloc] initWithActivityInstance:activityInstance methodName:@"Add"];
            [activityClient sendMethodInvocationWith:methodRequest delegate:delegate];

            [[expectFutureValue(delegate.activityInstance) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
            LogDebug("%@", delegate.activityInstance);
        });
    });



    SPEC_END