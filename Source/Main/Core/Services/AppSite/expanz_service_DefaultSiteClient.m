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


@interface expanz_service_DefaultSiteClient (private)

- (void) doRequestWith:(id<xml_Serializable>)xmlPayload
           forDelegate:(id<expanz_service_SiteClientDelegate>)delegate;

@end


@implementation expanz_service_DefaultSiteClient
@synthesize serviceUrl = _serviceUrl;

/* ================================================== Initializers ================================================== */
- (id) initWithServiceUrl:(NSString*)serviceUrl {
    self = [super init];
    if (self) {
        _serviceUrl = serviceUrl;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) listAvailableSitesWith:(id<expanz_service_SiteClientDelegate>)delegate {

    [self.httpTransport get:self.serviceUrl withBlock:^(LRRestyResponse* response) {

        if (response.status == 200) {
            LogDebug(@"Response: %@, ", [response asString]);
            RXMLElement* responseElement = [RXMLElement elementFromXMLString:[response asString]];

            SiteList* siteList = [[responseElement child:@"ListAvailableSitesXResult.ESA.AppSites"] asSiteList];
            [delegate requestDidFinishWithSiteList:siteList];
        }
        else {
            LogDebug(@"Oh fuck!!!!!!!!!");
            NSString* domain = NSStringFromClass([self class]);
            NSDictionary* userInfo = [NSDictionary dictionaryWithObject:[response asString] forKey:@"response"];
            NSError* error = [NSError errorWithDomain:domain code:response.status userInfo:userInfo];
            [delegate requestDidFailWithError:error];
        }
    }];
}


@end
