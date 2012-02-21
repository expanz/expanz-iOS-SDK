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

#import "../../../Source/Main/Core/Services/AppSite/Payload/RXMLElement+ListAvailableSites.h"
#import "expanz_model_AppSite.h"
#import "expanz_model_SiteList.h"
#import "TestResource.h"

SPEC_BEGIN(RXMLElement_ListAvailableSitesSpec)

    describe(@"Parsing response from ListAvailableSites service", ^{

        it(@"should return the AppSites as a collection", ^{
            
            NSString* responseXml = [TestResource withName:@"ListAvailableSitesResponse.xml"];
            RXMLElement* element = [RXMLElement elementFromXMLString:responseXml];
            SiteList* siteList = [[element child:@"ListAvailableSitesXResult.ESA.AppSites"] asSiteList];
            LogDebug(@"Site List: %@", siteList);
            [[[siteList sites] should] haveCountOf:3];
            for(AppSite* appSite in [siteList sites]) {
                LogDebug(@"AppSite: %@", appSite);
            }
            
        });
        
    
    });

SPEC_END