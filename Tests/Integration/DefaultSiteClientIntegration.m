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

#import "expanz_service_SiteClientDelegate.h"
#import "expanz_model_SiteList.h"
#import "expanz_service_SiteClient.h"
#import "JSObjectionInjector.h"
#import "JSObjection.h"
#import "expanz_CoreModule.h"
#import "IntegrationUtils.h"

/* ================================================================================================================== */
@interface TestSiteClientIntegrationDelegate : NSObject<expanz_service_SiteClientDelegate>
@property(nonatomic, strong) SiteList* siteList;
@end

@implementation TestSiteClientIntegrationDelegate
@synthesize siteList = _siteList;

- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList {
    LogDebug(@"Hello? %@", siteList);
    _siteList = siteList;
}

@end
/* ================================================================================================================== */

SPEC_BEGIN(DefaultSiteClientIntegration)

    
    __block id<expanz_service_SiteClient> siteClient;
    
    beforeAll(^{
        [IntegrationUtils useDefaultBackendForIntegrationTests];
        JSObjectionInjector* injector = [JSObjection createInjector:[[CoreModule alloc] init]]; 
        siteClient = [injector getObject:@protocol(expanz_service_SiteClient)];
    });
    
    
    it(@"should return a list of available sites", ^{
        TestSiteClientIntegrationDelegate* delegate = [[TestSiteClientIntegrationDelegate alloc] init];
        [siteClient listAvailableSitesWith:delegate];
        assertWillHappen(delegate.siteList != nil);

        LogDebug(@"Site List: %@", delegate.siteList);

    });


SPEC_END
