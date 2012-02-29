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

#import "TestResource.h"
#import "RXMLElement+ListActivitiesForSite.h"
#import "expanz_model_ActivityMenu.h"

SPEC_BEGIN(RXMLElement_ListActivitiesForSite)

    it(@"should be able to return itself as an ActivityDefinitionList", ^{

        NSString* xml = [TestResource withName:@"ListAvailableSitesXResponse.xml"];
        RXMLElement* element = [RXMLElement elementFromXMLString:xml];
        ActivityMenu* activityDefinitionList =
            [[element child:@"ListActivitiesForSiteXResult.ESA.Activities"] asActivityDefinitionList];

        LogDebug(@"List: %@", activityDefinitionList.activities);

        [[activityDefinitionList.activities should] haveCountOf:5];
        ActivityMenuItem* activityDefinition = [[activityDefinitionList activities] objectAtIndex:0];
        [[[activityDefinition activityId] should] equal:@"MySample.MyAdvancedCalculator"];
        [[[activityDefinition title] should] equal:@"Advanced Calculator"];


    });


    SPEC_END