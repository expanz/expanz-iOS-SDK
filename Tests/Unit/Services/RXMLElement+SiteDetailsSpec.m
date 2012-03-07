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

#import "RXMLElement+SiteDetails.h"
#import "expanz_model_AppSite.h"
#import "expanz_model_SiteList.h"
#import "TestResource.h"
#import "expanz_model_ActivityMenuItem.h"
#import "expanz_model_ActivityMenu.h"
#import "expanz_model_ActivitySchema.h"
#import "expanz_model_Query.h"

SPEC_BEGIN(RXMLElement_SiteDetails)

        describe(@"Parsing response from ListAvailableSites service", ^{

            it(@"should return the AppSites as a collection", ^{

                NSString* responseXml = [TestResource withName:@"ListAvailableSitesResponse.xml"];
                RXMLElement* element = [RXMLElement elementFromXMLString:responseXml];
                SiteList* siteList = [[element child:@"ListAvailableSitesXResult.ESA.AppSites"] asSiteList];
                LogDebug(@"Site List: %@", siteList);
                [[[siteList sites] should] haveCountOf:3];
                for (AppSite* appSite in [siteList sites]) {
                    LogDebug(@"AppSite: %@", appSite);
                }

            });
        });

        describe(@"Parsing response from ListActivitesForSiteX service", ^{
            it(@"should be able to return itself as an ActivityMenu", ^{

                NSString* xml = [TestResource withName:@"ListActivitiesForSiteXResult.xml"];
                RXMLElement* element = [RXMLElement elementFromXMLString:xml];
                ActivityMenu* menu = [[element child:@"ListActivitiesForSiteXResult.ESA.Activities"] asActivityMenu];

                LogDebug(@"List: %@", menu.activities);

                [[menu.activities should] haveCountOf:5];
                ActivityMenuItem* activityDefinition = [[menu activities] objectAtIndex:0];
                [[[activityDefinition activityId] should] equal:@"MySample.MyAdvancedCalculator"];
                [[[activityDefinition title] should] equal:@"Advanced Calculator"];


            });
        });

        describe(@"Parsing response from GetSchemeForActivityX service", ^{

            it(@"should be able to return itself as an ActivitySchema", ^{

                NSString* xml = [TestResource withName:@"GetSchemaForActivityXResponse.xml"];
                LogDebug(@"XML: %@", xml);

                RXMLElement* element = [RXMLElement elementFromXMLString:xml];
                ActivitySchema* schema = [[element child:@"GetSchemaForActivityXResult.ESA.Activity"] asActivitySchema];
                [[element child:@"GetSchemaForActivityXResult.ESA.Queries"] iterate:@"*" with:^(RXMLElement* e) {
                    [schema addQuery:[e asQuery]];
                }];


                [[[schema activityId] should] equal:@"Sales.Customer"];
                [[[schema title] should] equal:@"Customers"];

                LogDebug(@"Schema: %@", schema);
                [[[schema fields] should] haveCountOf:11];
                [[[schema methods] should] haveCountOf:8];

                [[[schema styles] should] haveCountOf:2];
                [[[[[schema styles] objectAtIndex:0] name] should] equal:@""];
                [[[[[schema styles] objectAtIndex:1] name] should] equal:@"Browse"];

                [[[[[schema fields] objectAtIndex:0] name] should] equal:@"CreditCard"];
                [[[[[schema methods] objectAtIndex:0] name] should] equal:@"DefaultActionMenu"];

                [[[schema queries] should] haveCountOf:1];
                Query* query = [[schema queries] objectAtIndex:0];
                [[[query fields] should] haveCountOf:3];
                LogDebug(@"Query fields: %@", [query fields]);

            });

        });


        SPEC_END