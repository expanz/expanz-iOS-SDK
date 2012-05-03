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

#import "expanz_model_SiteList.h"
#import "ExpanzSiteDetailsClient.h"
#import "JSObjectionInjector.h"
#import "JSObjection.h"
#import "expanz_CoreModule.h"
#import "IntegrationUtils.h"
#import "expanz_model_ActivityMenu.h"
#import "expanz_model_ActivitySchema.h"

/* ================================================================================================================== */
@interface TestSiteClientIntegrationDelegate : NSObject<ExpanzSiteDetailsClientDelegate>
@property(nonatomic, strong) SiteList* siteList;
@property(nonatomic, strong) ActivityMenu* activityList;
@property(nonatomic, strong) ActivitySchema* activitySchema;
@end

@implementation TestSiteClientIntegrationDelegate
@synthesize siteList = _siteList;
@synthesize activityList = _activityList;
@synthesize activitySchema = _activitySchema;

- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList {
    _siteList = siteList;
}

- (void) requestDidFinishWithActivityMenu:(expanz_model_ActivityMenu*)activityMenu {
    _activityList = activityMenu;
}

- (void) requestDidFinishWithActivitySchema:(expanz_model_ActivitySchema*)activitySchema {
    LogDebug(@"Delegate fire: %@", activitySchema);
    _activitySchema = activitySchema;
}

@end
/* ================================================================================================================== */

SPEC_BEGIN(DefaultSiteDetailsClientIntegration)


        __block id<ExpanzSiteDetailsClient> siteClient;
        __block TestSiteClientIntegrationDelegate* delegate;

        beforeEach(^{
            [IntegrationUtils useDefaultBackendForIntegrationTests];
            JSObjectionInjector* injector = [JSObjection createInjector:[[CoreModule alloc] init]];
            siteClient = [injector getObject:@protocol(ExpanzSiteDetailsClient)];
            delegate = [[TestSiteClientIntegrationDelegate alloc] init];
        });


        it(@"should return a list of available sites", ^{
            [siteClient listAvailableSitesWithDelegate:delegate];
            [[expectFutureValue(delegate.siteList) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
            LogDebug(@"Site List: %@", delegate.siteList);
        });

        it(@"should return a list of available activities for a site. ", ^{
            [siteClient listActivitiesForSite:@"SALES" withDelegate:delegate];
            [[expectFutureValue(delegate.activityList) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
            LogDebug(@"Activity List: %@", delegate.activityList);

        });

        it(@"should return the schema for an activity. ", ^{
            [siteClient site:@"SALES" requestSchemaForActivity:@"Sales.Customer" withDelegate:delegate];
            [[expectFutureValue(delegate.activitySchema) shouldEventuallyBeforeTimingOutAfter(5.0)] beNonNil];
            LogDebug(@"Activity List: %@", delegate.activitySchema);

        });



        SPEC_END
