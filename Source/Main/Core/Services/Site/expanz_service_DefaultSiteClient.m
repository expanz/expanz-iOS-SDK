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


#import "expanz_service_AbstractServiceClient.h"
#import "RXMLElement+ListAvailableSites.h"
#import "expanz_service_SiteClientDelegate.h"
#import "expanz_service_DefaultSiteClient.h"
#import "expanz_model_SiteList.h"
#import "expanz_model_ActivityDefinitionList.h"
#import "RXMLElement+ListActivitiesForSite.h"


@interface expanz_service_DefaultSiteClient (private)

- (void) doRequestWith:(id<xml_Serializable>)xmlPayload
           forDelegate:(id<expanz_service_SiteClientDelegate>)delegate;

@end


@implementation expanz_service_DefaultSiteClient

@synthesize listAvailableSitesUrl = _listAvailableSitesUrl;
@synthesize listActivitiesForSiteUrl = _listActivitiesForSiteUrl;


/* ================================================== Initializers ================================================== */
- (id) initWithListAvailableSitesUrl:(NSString*)listAvailableSitesUrl
            listActivitiesForSiteUrl:(NSString*)listActivitiesForSiteUrl {
    self = [super init];
    if (self) {
        _listAvailableSitesUrl = listAvailableSitesUrl;
        _listActivitiesForSiteUrl = listActivitiesForSiteUrl;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) listAvailableSitesWith:(id<expanz_service_SiteClientDelegate>)delegate {

    [self.httpTransport get:self.listAvailableSitesUrl withBlock:^(LRRestyResponse* response) {

        if (response.status == 200) {
            LogDebug(@"Response: %@, ", [response asString]);
            RXMLElement* responseElement = [RXMLElement elementFromXMLString:[response asString]];

            SiteList* siteList = [[responseElement child:@"ListAvailableSitesXResult.ESA.AppSites"] asSiteList];
            [delegate requestDidFinishWithSiteList:siteList];
        }
        else {
            [super dispatchErrorWith:delegate statusCode:response.status userInfo:[response asString]];
        }
    }];
}

- (void) listActivitiesForSite:(NSString*)site with:(id<expanz_service_SiteClientDelegate>)delegate {
    NSDictionary* parameters = [NSDictionary dictionaryWithObject:site forKey:@"site"];
    [self.httpTransport get:self.listActivitiesForSiteUrl parameters:parameters withBlock:^(LRRestyResponse* response) {

        if (response.status == 200) {
            LogDebug(@"Response: %@", [response asString]);
            ActivityDefinitionList* activityList = [[[RXMLElement elementFromXMLString:[response asString]]
                child:@"ListActivitiesForSiteXResult.ESA.Activities"] asActivityDefinitionList];
            [delegate requestDidFinishWithActivityList:activityList];
        }
        else {
            [super dispatchErrorWith:delegate statusCode:response.status userInfo:[response asString]];
        }

    }];

}


@end
