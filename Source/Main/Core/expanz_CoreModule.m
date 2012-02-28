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

#import "expanz_SdkConfiguration.h"
#import "expanz_CoreModule.h"
#import "expanz_service_DefaultSessionDataClient.h"
#import "expanz_service_DefaultActivityClient.h"
#import "expanz_service_DefaultDownloadClient.h"
#import "expanz_service_DefaultLoginClient.h"
#import "expanz_service_SiteClient.h"
#import "expanz_service_DefaultSiteClient.h"


@implementation expanz_CoreModule

- (void) configure {
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        return [[DefaultActivityClient alloc]
            initWithServiceUrl:[[SdkConfiguration globalConfiguration] execXServiceUrl]];
    }    toProtocol:@protocol(expanz_service_ActivityClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        return [[DefaultDownloadClient alloc]
            initWithFileRequestUrl:[[SdkConfiguration globalConfiguration] execXServiceUrl]
                        getBlobUrl:[[SdkConfiguration globalConfiguration] getBlobServiceUrl]];
    }    toProtocol:@protocol(expanz_service_FileDownloadClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        return [[DefaultLoginClient alloc]
            initWithServiceUrl:[[SdkConfiguration globalConfiguration] createSessionServiceUrl]];
    }    toProtocol:@protocol(expanz_service_LoginClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        return [[DefaultSessionDataClient alloc]
            initWithServiceUrl:[[SdkConfiguration globalConfiguration] execXServiceUrl]];
    }    toProtocol:@protocol(expanz_service_SessionDataClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        return [[DefaultSiteClient alloc]
            initWithListAvailableSitesUrl:[[SdkConfiguration globalConfiguration] listAvailableSitesUrl]
                 listActivitiesForSiteUrl:[[SdkConfiguration globalConfiguration] listActivitiesForSiteUrl]];
    }    toProtocol:@protocol(expanz_service_SiteClient)];

}
@end