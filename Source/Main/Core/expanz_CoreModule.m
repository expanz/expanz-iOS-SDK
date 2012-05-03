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
#import "expanz_service_DefaultSiteDetailsClient.h"


@implementation expanz_CoreModule

- (void) configure {
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultActivityClient alloc] initWithServiceUrl:[config execXServiceUrl]];
    }    toProtocol:@protocol(ExpanzActivityClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultDownloadClient alloc]
                initWithFileRequestUrl:[config execXServiceUrl] getBlobUrl:[config getBlobServiceUrl]];
    }    toProtocol:@protocol(ExpanzFileDownloadClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultLoginClient alloc] initWithServiceUrl:[config createSessionServiceUrl]];
    }    toProtocol:@protocol(ExpanzLoginClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultSessionDataClient alloc] initWithServiceUrl:[config execXServiceUrl]];
    }    toProtocol:@protocol(ExpanzSessionDataClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        SdkConfiguration* config = [SdkConfiguration globalConfiguration];
        return [[DefaultSiteDetailsClient alloc] initWithListAvailableSitesUrl:[config listAvailableSitesUrl]
                                                      listActivitiesForSiteUrl:[config listActivitiesForSiteUrl]
                                                          schemaForActivityUrl:[config schemaForActivityUrl]];
    }    toProtocol:@protocol(ExpanzSiteDetailsClient)];

}
@end