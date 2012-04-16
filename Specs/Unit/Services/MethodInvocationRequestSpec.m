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

#import "expanz_service_MethodInvocationRequest.h"
#import "expanz_model_ActivityInstance.h"


SPEC_BEGIN(MethodInvocationRequestSpec)

    __block MethodInvocationRequest* methodRequest;

    beforeEach(^{
        ActivityInstance* activity =
            [[ActivityInstance alloc] initWithTitle:@"Calc" handle:@"1234" persistentId:@"0"];
        methodRequest =
            [[MethodInvocationRequest alloc] initWithActivityInstance:activity methodName:@"Add"];
    });


    describe(@"Objection creation", ^{

        it(@"should allow creation with activityInstance and method name attributes.", ^{
            [methodRequest shouldNotBeNil];
            [[methodRequest activityInstance] shouldNotBeNil];
            [[methodRequest methodName] shouldNotBeNil];
        });
    });

    describe(@"xml marshalling", ^{

        it(@"should allow marshalling to xml for sending to the service endpoint.", ^{
            id <xml_Serializable> xmlable = (id <xml_Serializable>) methodRequest;
            NSString* xml = [xmlable toXml];
            LogDebug(@"Xml: %@", xml);
            [xml shouldNotBeNil];
        });


    });


    SPEC_END