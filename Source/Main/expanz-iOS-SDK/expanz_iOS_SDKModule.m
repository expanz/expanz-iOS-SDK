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

//Current Environment
#import "expanz_iOS_SDKConfiguration.h"

@implementation expanz_iOS_SDKModule

- (void) configure {
    SDKConfiguration* config = [SDKConfiguration globalConfiguration];

    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:config.createSessionUrl];
        XmlPostLoginClient* client = [[[XmlPostLoginClient alloc] initWithRequest:request] autorelease];
        [request release];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_LoginClient)];

    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:config.execUrl];
        XmlPostSessionDataClient* client = [[[XmlPostSessionDataClient alloc] initWithRequest:request] autorelease];
        [request release];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_SessionDataClient)];
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector* context) {
        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:config.execUrl];
        XmlPostActivityClient* client = [[[XmlPostActivityClient alloc] initWithRequest:request] autorelease];
        [request release];
        return (id) client;
    }    toProtocol:@protocol(expanz_service_ActivityClient)];
}

@end 
