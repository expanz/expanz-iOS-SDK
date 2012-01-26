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

#import "expanz_iOS_SDKModule.h"
#import "expanz_iOS_SDKConfiguration.h"
#import "expanz_service_XmlPostActivityClient.h"
#import "expanz_service_XmlPostFileDownloadClient.h"
#import "expanz_service_XmlPostLoginClient.h"
#import "expanz_service_XmlPostSessionDataClient.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_ui_AlertBoxSystemEventReporter.h"
#import "expanz_service_FileDownloadClient.h"

@implementation expanz_iOS_SDKModule

- (void) configure {
    [self bindClass:[AlertBoxSystemEventReporter class] toProtocol:@protocol(expanz_ui_SystemEventReporter)];
    SDKConfiguration* config = [SDKConfiguration globalConfiguration];

    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        XmlPostActivityClient* client = [[XmlPostActivityClient alloc] initWithServiceUrl:config.execXServiceUrl];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_ActivityClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        XmlPostFileDownloadClient* client =
            [[XmlPostFileDownloadClient alloc] initWithServiceUrl:config.execXServiceUrl];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_FileDownloadClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        XmlPostLoginClient* client = [[XmlPostLoginClient alloc] initWithServiceUrl:config.createSessionServiceUrl];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_LoginClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        XmlPostSessionDataClient* client = [[XmlPostSessionDataClient alloc] initWithServiceUrl:config.execXServiceUrl];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_SessionDataClient)];
    /* ============================================================================================================== */


}

@end 
