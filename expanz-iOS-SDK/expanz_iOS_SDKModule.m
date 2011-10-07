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
#import "test_expanz_com_ServiceUrls.h"
#import "expanz_service_XmlPostLoginClient.h"
#import "expanz_service_XmlPostSessionDataClient.h"


@implementation expanz_iOS_SDKModule

- (void)configure {
    
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector *context) {
        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kCreateSessionUrl]];        
        XmlPostLoginClient* client = [[XmlPostLoginClient alloc] initWithRequest:request];
        [request release];
        return (id) client;
    } toProtocol:@protocol(expanz_service_LoginClient)];         
    
    /* ============================================================================================================== */
    [self bindBlock:^(JSObjectionInjector *context) {
        ASIFormDataRequest* request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:kGetSessionDataUrl]];        
        XmlPostSessionDataClient* client = [[XmlPostSessionDataClient alloc] initWithRequest:request];
        return (id) client;
    } toProtocol:@protocol(expanz_service_SessionDataClient)];         
}


@end 
