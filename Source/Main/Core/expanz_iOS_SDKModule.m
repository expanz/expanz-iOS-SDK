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

#import "expanz_ios_SdkModule.h"
#import "expanz_ios_SdkConfiguration.h"
#import "expanz_service_DefaultActivityClient.h"
#import "expanz_service_DefaultDownloadClient.h"
#import "expanz_service_DefaultLoginClient.h"
#import "expanz_service_DefaultDataClient.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_ui_AlertBoxSystemEventReporter.h"
#import "expanz_service_FileDownloadClient.h"

@implementation expanz_ios_SdkModule

- (void) configure {
    [self bindClass:[AlertBoxSystemEventReporter class] toProtocol:@protocol(expanz_ui_SystemEventReporter)];
    SdkConfiguration* config = [SdkConfiguration globalConfiguration];

    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        return [[DefaultActivityClient alloc] initWithServiceUrl:[config.execXServiceUrl absoluteString]];
    }    toProtocol:@protocol(expanz_service_ActivityClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        return [[DefaultDownloadClient alloc] initWithFileRequestUrl:[config.execXServiceUrl absoluteString]
                                                              getBlobUrl:[config.getBlobServiceUrl absoluteString]];
    }    toProtocol:@protocol(expanz_service_FileDownloadClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        return [[DefaultLoginClient alloc] initWithServiceUrl:[config.createSessionServiceUrl absoluteString]];
    }    toProtocol:@protocol(expanz_service_LoginClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        return [[DefaultDataClient alloc] initWithServiceUrl:[config.execXServiceUrl absoluteString]];
    }    toProtocol:@protocol(expanz_service_SessionDataClient)];
    /* ============================================================================================================== */


}

@end 
