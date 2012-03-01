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
#import "RXMLElement+SiteDetails.h"
#import "expanz_model_ActivityMenu.h"

SPEC_BEGIN(RXMLElement_ListActivitiesForSite)

    it(@"should be able to return itself as an ActivityDefinitionList", ^{

        NSString* xml = [TestResource withName:@"ListActivitiesForSiteXResult.xml"];
        LogDebug(@"XML: %@", xml);
        RXMLElement* element = [RXMLElement elementFromXMLString:xml];
        ActivityMenu* actvityMenu = [[element child:@"ListActivitiesForSiteXResult.ESA.Activities"] asActivityMenu];

        LogDebug(@"List: %@", actvityMenu.activities);

        [[actvityMenu.activities should] haveCountOf:5];
        ActivityMenuItem* activityDefinition = [[actvityMenu activities] objectAtIndex:0];
        [[[activityDefinition activityId] should] equal:@"MySample.MyAdvancedCalculator"];
        [[[activityDefinition title] should] equal:@"Advanced Calculator"];


    });


    SPEC_END