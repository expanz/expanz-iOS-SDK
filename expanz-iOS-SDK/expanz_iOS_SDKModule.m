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
#import "JBPackageVoodoo.h"
#import "ASIFormDataRequest.h"


@implementation expanz_iOS_SDKModule

- (void)configure {
    
    [self bindBlock:^(JSObjectionInjector *context) {
        ASIFormDataRequest* loginRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:kCreateSessionUrl]];
        XmlPostLoginClient* loginClient = [[XmlPostLoginClient alloc] initWithLoginRequest:loginRequest];
        return (id) loginClient;
    } toProtocol:@protocol(expanz_service_LoginClient)];         
}


@end 
