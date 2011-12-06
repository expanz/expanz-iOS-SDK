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
#import "ASIFormDataRequest.h"
#import "expanz_service_XmlPostLoginClient.h"
#import "expanz_service_XmlPostSessionDataClient.h"
#import "expanz_service_XmlPostActivityClient.h"
#import "../UserInterface/expanz_ui_AlertBoxSystemEventReporter.h"

#import "expanz_iOS_SDKConfiguration.h"
#import "../UserInterface/expanz_ui_NavigationManager.h"

@implementation expanz_iOS_SDKModule

- (void)configure {
    SDKConfiguration* config = [SDKConfiguration globalConfiguration];

    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        XmlPostLoginClient* client =
            [[[XmlPostLoginClient alloc] initWithServiceUrl:config.createSessionUrl] autorelease];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_LoginClient)];

    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        XmlPostSessionDataClient* client =
            [[[XmlPostSessionDataClient alloc] initWithServiceUrl:config.execUrl] autorelease];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_SessionDataClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        XmlPostActivityClient* client = [[[XmlPostActivityClient alloc] initWithServiceUrl:config.execUrl] autorelease];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_ActivityClient)];
    /* ================================================================================================================== */
    [self bindClass:[AlertBoxSystemEventReporter class] toProtocol:@protocol(expanz_ui_SystemEventReporter)];

}

@end 
