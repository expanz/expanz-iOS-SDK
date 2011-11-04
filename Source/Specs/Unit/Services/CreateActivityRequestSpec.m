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
#import "expanz_service_CreateActivityRequest.h"
#import "RXMLElement.h"
#import "expanz_service_DataPublicationRequest.h"


SPEC_BEGIN(CreateActivityRequestSpec)

    describe(@"Object creation", ^{

        it(@"should allow initialization with activityName and sessionToken parameters.", ^{
            CreateActivityRequest* request = [[CreateActivityRequest alloc]
                initWithActivityName:@"Calculator" style:nil sessionToken:@"EggResponderxx238b"];
            assertThat([request activityName], equalTo(@"Calculator"));
            assertThat([request style], nilValue());
            assertThat([request sessionToken], equalTo(@"EggResponderxx238b"));
        });

    });

    describe(@"Web service integration.", ^{

        it(@"should be able to marshal itself to XML to send over the wire as a web service request.", ^{
            id <xml_Serializable> request =
                [[CreateActivityRequest alloc] initWithActivityName:@"Calculator" style:nil sessionToken:@"xx2348b"];
            RXMLElement* e = [RXMLElement elementFromXMLString:[request toXml]];
            assertThat(e, notNilValue());
        });

        it(@"Should allow inclusion of DataPublicationRequests in the request body", ^{
            CreateActivityRequest* request = [[CreateActivityRequest alloc]
                initWithActivityName:@"Calculator" style:@"Browse" sessionToken:@"xx2348b"];

            UITableView* tableView = [[UITableView alloc] init];

            DataPublicationRequest* dataPublicationRequest = [request dataPublicationRequestFor:tableView];
            [dataPublicationRequest setPopulateMethod:@"ListMe"];
            [dataPublicationRequest setDataPublicationId:@"customersList"];
            [dataPublicationRequest setAutoPopulate:YES];

            UITableView* anotherTableView = [[UITableView alloc] init];
            DataPublicationRequest* another = [request dataPublicationRequestFor:anotherTableView];
            [another setPopulateMethod:@"ListMeCustomized"];
            [another setDataPublicationId:@"ordersList"];
            [another setAutoPopulate:NO];

            LogDebug(@"%@", [request toXml]);
            assertThatInt([[request dataPublicationRequests] count], equalToInt(2));
            assertThat([request toXml], containsString(@"DataPublication id=\"customersList\""));
            assertThat([request toXml], containsString(@"DataPublication id=\"ordersList\""));

            [request release];
        });
    });


    SPEC_END
