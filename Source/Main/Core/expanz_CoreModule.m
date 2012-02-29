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
#import "expanz_service_SiteDetailsClient.h"
#import "expanz_service_DefaultSiteDetailsClient.h"


@implementation expanz_CoreModule

- (void) configure {
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultActivityClient alloc] initWithServiceUrl:[config execXServiceUrl]];
    }    toProtocol:@protocol(expanz_service_ActivityClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultDownloadClient alloc]
                initWithFileRequestUrl:[config execXServiceUrl] getBlobUrl:[config getBlobServiceUrl]];
    }    toProtocol:@protocol(expanz_service_FileDownloadClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultLoginClient alloc] initWithServiceUrl:[config createSessionServiceUrl]];
    }    toProtocol:@protocol(expanz_service_LoginClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultSessionDataClient alloc] initWithServiceUrl:[config execXServiceUrl]];
    }    toProtocol:@protocol(expanz_service_SessionDataClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultSiteDetailsClient alloc] initWithListAvailableSitesUrl:[config listAvailableSitesUrl]
                                                      listActivitiesForSiteUrl:[config listActivitiesForSiteUrl]
                                                          schemaForActivityUrl:[config schemaForActivityUrl]];
    }    toProtocol:@protocol(expanz_service_SiteDetailsClient)];

}
@end