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
#import "expanz_service_SiteDetailsClientDelegate.h"
#import "expanz_service_DefaultSiteDetailsClient.h"
#import "expanz_model_SiteList.h"
#import "expanz_model_ActivityMenu.h"
#import "RXMLElement+SiteDetails.h"
#import "expanz_model_ActivitySchema.h"


@interface expanz_service_DefaultSiteDetailsClient (private)

- (void) doRequestWith:(id<xml_Serializable>)xmlPayload
        forDelegate:(id<expanz_service_SiteDetailsClientDelegate>)delegate;

@end


@implementation expanz_service_DefaultSiteDetailsClient

@synthesize listAvailableSitesUrl = _listAvailableSitesUrl;
@synthesize listActivitiesForSiteUrl = _listActivitiesForSiteUrl;
@synthesize schemaForActivityUrl = _schemaForActivityUrl;


/* ================================================== Initializers ================================================== */
- (id) initWithListAvailableSitesUrl:(NSString*)listAvailableSitesUrl
        listActivitiesForSiteUrl:(NSString*)listActivitiesForSiteUrl
        schemaForActivityUrl:(NSString*)schemaForActivityUrl {

    self = [super init];
    if (self) {
        _listAvailableSitesUrl = listAvailableSitesUrl;
        _listActivitiesForSiteUrl = listActivitiesForSiteUrl;
        _schemaForActivityUrl = schemaForActivityUrl;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) listAvailableSitesWithDelegate:(id<expanz_service_SiteDetailsClientDelegate>)delegate {

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

- (void) listActivitiesForSite:(NSString*)site withDelegate:(id<expanz_service_SiteDetailsClientDelegate>)delegate {

    NSDictionary* parameters = [NSDictionary dictionaryWithObject:site forKey:@"site"];
    [self.httpTransport get:self.listActivitiesForSiteUrl parameters:parameters withBlock:^(LRRestyResponse* response) {

        if (response.status == 200) {
            LogDebug(@"Response: %@", [response asString]);
            ActivityMenu* activityList = [[[RXMLElement elementFromXMLString:[response asString]]
                    child:@"ListActivitiesForSiteXResult.ESA.Activities"] asActivityMenu];
            [delegate requestDidFinishWithActivityMenu:activityList];
        }
        else {
            LogDebug(@"In dispatch error");
            [super dispatchErrorWith:delegate statusCode:response.status userInfo:[response asString]];
        }

    }];
}


- (void) site:(NSString*)siteId retriveSchemaForActivity:(NSString*)activityId
        withDelegate:(id<expanz_service_SiteDetailsClientDelegate>)delegate {

    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:siteId, @"site", activityId, @"activity", nil];
    [self.httpTransport get:self.schemaForActivityUrl parameters:params withBlock:^(LRRestyResponse* response) {

        if (response.status == 200) {
            LogDebug(@"Response: %@", [response asString]);
            ActivitySchema* activitySchema = [[[RXMLElement elementFromXMLString:[response asString]]
                    child:@"GetSchemaForActivityXResult.ESA.Activity"] asActivitySchema];
            [delegate requestDidFinishWithActivitySchema:activitySchema];
        }
        else {
            LogDebug(@"In dispatch error");
            [super dispatchErrorWith:delegate statusCode:response.status userInfo:[response asString]];
        }

    }];


}

@end
