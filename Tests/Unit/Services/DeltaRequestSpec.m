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

#import "expanz_service_DeltaRequest.h"
#import "expanz_model_Field.h"
#import "NSData+ExpanzAdditions.h"

SPEC_BEGIN(DeltaRequestSpec)

/* ================================================================================================================== */
        describe(@"object creation", ^{
            it(@"should allow initialization with fieldId, fieldValue, activityHandle and sessionToken parameters.", ^{
                DeltaRequest* request = [[DeltaRequest alloc]
                        initWithFieldId:@"op1" fieldValue:@"23" activityHandle:@"234234" sessionToken:@"tokenXXYY"];
                [request shouldNotBeNil];
                [[request fieldId] shouldNotBeNil];
                [[request fieldValue] shouldNotBeNil];
                [[request activityHandle] shouldNotBeNil];
                [[request sessionToken] shouldNotBeNil];

            });

            it(@"Should provide a factory method to convert a field model instance into a delta request. ", ^{
                Field* field = [[Field alloc]
                        initWithFieldId:@"customerName" nullable:YES defaultValue:nil dataType:ExpanzDataTypeString
                        label:@"Enter a customer name" hint:@"Figure it out, dude!"];
                DeltaRequest* deltaRequest = [DeltaRequest forField:field];

                [deltaRequest shouldNotBeNil];

            });

        });


#define kExpectedXml @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><Activity activityHandle=\"234234\">\
<Delta id=\"op1\"  value=\"23\"></Delta></Activity></ESA></xml><sessionHandle>tokenXXYY</sessionHandle></ExecX>"

#define kExpectedXmlWithBase64Data @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><Activity \
activityHandle=\"234234\"><Delta id=\"op1\" encoding=\"BASE64\" value=\"$longData$\">VGhlIHF1aWNrIGJyb3duIGZveA==\
</Delta></Activity></ESA></xml><sessionHandle>tokenXXYY</sessionHandle></ExecX>"

        describe(@"XML marshalling", ^{
            it(@"should allow serialization to xml", ^{
                DeltaRequest* request = [[DeltaRequest alloc]
                        initWithFieldId:@"op1" fieldValue:@"23" activityHandle:@"234234" sessionToken:@"tokenXXYY"];

                LogDebug(@"%@", [request toXml]);
                [[[request toXml] should] equal:kExpectedXml];

            });

            it(@"should mark the data as base64 encoded, if required. ", ^{

                NSString* base64String =
                        [[@"The quick brown fox" dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];

                LogDebug(@"%@", base64String);

                DeltaRequest* request = [[DeltaRequest alloc]
                        initWithFieldId:@"op1" fieldValue:base64String activityHandle:@"234234"
                        sessionToken:@"tokenXXYY" encoding:DeltaEncodingBase64];

                LogDebug(@"%@", [request toXml]);
                [[[request toXml] should] equal:kExpectedXmlWithBase64Data];

            });


        });


/* ================================================================================================================== */
        SPEC_END