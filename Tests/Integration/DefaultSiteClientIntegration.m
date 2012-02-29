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

#import "expanz_service_SiteDetailsClientDelegate.h"
#import "expanz_model_SiteList.h"
#import "expanz_service_SiteDetailsClient.h"
#import "JSObjectionInjector.h"
#import "JSObjection.h"
#import "expanz_CoreModule.h"
#import "IntegrationUtils.h"
#import "expanz_model_ActivityMenu.h"

/* ================================================================================================================== */
@interface TestSiteClientIntegrationDelegate : NSObject<expanz_service_SiteDetailsClientDelegate>
@property(nonatomic, strong) SiteList* siteList;
@property(nonatomic, strong) ActivityMenu* activityList;
@end

@implementation TestSiteClientIntegrationDelegate
@synthesize siteList = _siteList;
@synthesize activityList = _activityList;


- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList {
    _siteList = siteList;
}

- (void) requestDidFinishWithActivityList:(expanz_model_ActivityMenu*)activityList {
    _activityList = activityList;
}


@end
/* ================================================================================================================== */

SPEC_BEGIN(DefaultSiteClientIntegration)


    __block id<expanz_service_SiteDetailsClient> siteClient;
    __block TestSiteClientIntegrationDelegate* delegate;

    beforeEach(^{
        [IntegrationUtils useDefaultBackendForIntegrationTests];
        JSObjectionInjector* injector = [JSObjection createInjector:[[CoreModule alloc] init]];
        siteClient = [injector getObject:@protocol(expanz_service_SiteDetailsClient)];
        delegate = [[TestSiteClientIntegrationDelegate alloc] init];
    });


    it(@"should return a list of available sites", ^{
        [siteClient listAvailableSitesWith:delegate];
        [[expectFutureValue(delegate.siteList) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
        LogDebug(@"Site List: %@", delegate.siteList);
    });

    it(@"should return a list of available activities for a site. ", ^{
        [siteClient listActivitiesForSite:@"SALES" with:delegate];
        [[expectFutureValue(delegate.activityList) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
        LogDebug(@"Activity List: %@", delegate.activityList);

    });


    SPEC_END
