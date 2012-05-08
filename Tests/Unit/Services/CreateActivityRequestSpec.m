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

#import "xml_Serializable.h"
#import "expanz_service_CreateActivityRequest.h"
#import "RXMLElement.h"
#import "expanz_service_DataPublicationRequest.h"
#import "NSString+Contains.h"


SPEC_BEGIN(CreateActivityRequestSpec)

/* ================================================================================================================== */
    describe(@"Object creation", ^{

        it(@"should allow initialization with activityName and sessionToken parameters.", ^{
            CreateActivityRequest* request = [[CreateActivityRequest alloc]
                initWithActivityName:@"Calculator" style:[ActivityStyle browseStyle] initialKey:nil
                        sessionToken:@"EggResponderxx238b"];
            [[[request activityName] should] equal:@"Calculator"];
            [[theValue([[request style] isBrowse]) should] beYes];
            [[[request sessionToken] should] equal:@"EggResponderxx238b"];
        });

    });

/* ================================================================================================================== */
    describe(@"Web service integration.", ^{

        it(@"should be able to marshal itself to XML to send over the wire as a web service request.", ^{
            id<xml_Serializable> request = [[CreateActivityRequest alloc]
                initWithActivityName:@"Calculator" style:[ActivityStyle defaultStyle] initialKey:nil
                        sessionToken:@"xx2348b"];
            RXMLElement* e = [RXMLElement elementFromXMLString:[request toXml] encoding:NSUTF8StringEncoding];
            [e shouldNotBeNil];
        });

        it(@"Should allow inclusion of DataPublicationRequests in the request body", ^{
            CreateActivityRequest* request = [[CreateActivityRequest alloc]
                initWithActivityName:@"Calculator" style:[ActivityStyle defaultStyle] initialKey:nil
                        sessionToken:@"xx2348b"];

            UITableView* tableView = [[UITableView alloc] init];

            DataPublicationRequest* dataPublicationRequest =
                [request dataPublicationRequestFor:[NSValue valueWithPointer:(__bridge void*) tableView]];
            [dataPublicationRequest setPopulateMethod:@"ListMe"];
            [dataPublicationRequest setDataPublicationId:@"customersList"];
            [dataPublicationRequest setAutoPopulate:YES];

            UITableView* anotherTableView = [[UITableView alloc] init];
            DataPublicationRequest* another =
                [request dataPublicationRequestFor:[NSValue valueWithPointer:(__bridge void*) anotherTableView]];
            [another setPopulateMethod:@"ListMeCustomized"];
            [another setDataPublicationId:@"ordersList"];
            [another setAutoPopulate:NO];

            LogDebug(@"%@", [request toXml]);
            [[[request dataPublicationRequests] should] haveCountOf:2];


        });
    });

/* ================================================================================================================== */
    SPEC_END
