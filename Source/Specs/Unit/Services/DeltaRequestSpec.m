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
#import "expanz_service_DeltaRequest.h"
#import "expanz_model_Field.h"

SPEC_BEGIN(DeltaRequestSpec)


    describe(@"object creation", ^{
        it(@"should allow initialization with fieldId, fieldValue, activityHandle and sessionToken parameters.", ^{
            DeltaRequest* request = [[DeltaRequest alloc]
                initWithFieldId:@"op1" fieldValue:@"23" activityHandle:@"234234" sessionToken:@"tokenXXYY"];
            assertThat(request, notNilValue());
            assertThat(request.fieldId, notNilValue());
            assertThat(request.fieldValue, notNilValue());
            assertThat(request.activityHandle, notNilValue());
            assertThat(request.sessionToken, notNilValue());

            [request release];
        });

        it(@"Should provide a factory method to convert a field model instance into a delta request. ", ^{
            Field* field = [[Field alloc]
                initWithFieldId:@"customerName" nullable:YES defaultValue:nil dataType:@"string"
                          label:@"Enter a customer name" hint:@"Figure it out, dude!"];
            DeltaRequest* deltaRequest = [DeltaRequest fromField:field];
            [field release];

            assertThat(deltaRequest, notNilValue());
        });

    });


#define kExpectedXml @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><Activity activityHandle=\"234234\">\
<Delta id=\"op1\" value=\"23\"/></Activity></ESA></xml><sessionHandle>tokenXXYY</sessionHandle></ExecX>"

    describe(@"XML marshalling", ^{
        it(@"should allow serialization to xml", ^{
            DeltaRequest* request = [[DeltaRequest alloc]
                initWithFieldId:@"op1" fieldValue:@"23" activityHandle:@"234234" sessionToken:@"tokenXXYY"];

            assertThat([request toXml], equalTo(kExpectedXml));
            [request release];

        });

    });

    SPEC_END