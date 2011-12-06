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
#import "StubActivityClientDelegate.h"
#import "IntegrationUtils.h"
#import "expanz_iOS_SDKModule.h"
#import "expanz_service_ActivityClient.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_service_XmlPostActivityClient.h"
#import "expanz_service_DeltaRequest.h"
#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_service_FileRequest.h"

SPEC_BEGIN(XmlPostActivityClientIntegration)

    __block id<expanz_service_ActivityClient> activityClient;
    __block StubActivityClientDelegate* delegate;

    beforeEach(^{
        [IntegrationUtils loginWithDefaultUserIfRequired];
        JSObjectionInjector* injector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]];
        activityClient = [injector getObject:@protocol(expanz_service_ActivityClient)];
        delegate = [[[StubActivityClientDelegate alloc] init] autorelease];
    });


    describe(@"create activity. . . ", ^{

        it(@"should return activity details upon invocation", ^{
            CreateActivityRequest* activityRequest = [[[CreateActivityRequest alloc]
                initWithActivityName:@"ESA.Sales.Calc" style:[ActivityStyle defaultStyle] initialKey:nil
                        sessionToken:[SessionContext globalContext].sessionToken] autorelease];

            [activityClient createActivityWith:activityRequest delegate:delegate];
            assertWillHappen(delegate.activityInstance != nil);
        });

        it(@"should invoke the delegate's error handler, if the underlying ASIFormDataRequest fails.", ^{
            CreateActivityRequest* activityRequest = [[[CreateActivityRequest alloc]
                initWithActivityName:@"ESA.Sales.Calc" style:[ActivityStyle defaultStyle] initialKey:nil
                        sessionToken:[SessionContext globalContext].sessionToken] autorelease];

            id<expanz_service_ActivityClient>
                anotherClient = [[XmlPostActivityClient alloc] initWithServiceUrl:[IntegrationUtils urlThatWillFail]];
            [anotherClient createActivityWith:activityRequest delegate:delegate];
            assertWillHappen(delegate.error != nil);
            LogDebug(@"Error %@", delegate.error);
        });

    });

    describe(@"sending deltas", ^{

        it(@"should allow sending updated field values", ^{

            NSString* activityHandle = [IntegrationUtils aValidActivity].handle;
            LogDebug(@"Activity handle: %@", activityHandle);
            DeltaRequest* deltaRequest = [[DeltaRequest alloc]
                initWithFieldId:@"Op1" fieldValue:@"623" activityHandle:activityHandle
                   sessionToken:[SessionContext globalContext].sessionToken];
            LogDebug(@"%@", [deltaRequest toXml]);
            [activityClient sendDeltaWith:deltaRequest delegate:delegate];

            assertWillHappen(delegate.activityInstance != nil);
            LogDebug(@"%@", delegate.activityInstance);
        });
    });

    describe(@"server method invocations.", ^{

        it(@"should allow sending invoking methods on the server-side model.", ^{
            ActivityInstance* activityInstance = [IntegrationUtils aValidActivity];
            MethodInvocationRequest* methodRequest =
                [[MethodInvocationRequest alloc] initWithActivityInstance:activityInstance methodName:@"Add"];
            [activityClient sendMethodInvocationWith:methodRequest delegate:delegate];

            assertWillHappen(delegate.activityInstance != nil);
            LogDebug("%@", delegate.activityInstance);
        });
    });



SPEC_END