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

#import "expanz_service_DataPublicationRequest.h"

SPEC_BEGIN(DataPublicationRequestSpec)

    __block DataPublicationRequest* request;
    beforeEach(^{
        request = [[DataPublicationRequest alloc] init];
    });

    describe(@"Mutable properties", ^{

        it(@"should default the populateMethod attribute to 'ListMe'", ^{
            [[[request populateMethod] should] equal:@"ListMe"];
        });

        it(@"should default the autoPopulate attribute to YES", ^{
            [[theValue([request autoPopulate]) should] beYes];
        });

        it(@"should clear the populateMethod property, when the query property is set.", ^{
            [request setQuery:@"CustomersListMobile"];
            [[[request query] should] equal:@"CustomersListMobile"];
            [[request populateMethod] shouldBeNil];
        });

    });

SPEC_END