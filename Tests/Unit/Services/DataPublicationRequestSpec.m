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

            it(@"should set the context object property when serializing to xml, only if non-null", ^{
                NSString* requestXml = [request toXml];
                LogDebug("Xml: %@", requestXml);
                [[requestXml should] equal:@"<DataPublication useThumbNailImages=\"1\" id=\"(null)\" "
                                                   "populateMethod=\"ListMe\" query=\"\"  autoPopulate=\"1\"/>"];

                [request setContextObject:@"People"];
                requestXml = [request toXml];
                LogDebug("Xml: %@", requestXml);
                [[requestXml should]
                        equal:@"<DataPublication useThumbNailImages=\"1\" id=\"(null)\" populateMethod=\"ListMe\" "
                                      "query=\"\" contextObject = \"People\"  autoPopulate=\"1\"/>"];



            });

        });

        SPEC_END