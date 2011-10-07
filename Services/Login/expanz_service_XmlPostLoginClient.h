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

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
#import "expanz_service_XmlPostWebService.h"
#import "expanz_service_XmlPostLoginClient.h"
#import "expanz_service_LoginClient.h"


@interface expanz_service_XmlPostLoginClient : XmlPostWebService<expanz_service_LoginClient>@end

/* ================================================================================================================== */
@compatibility_alias XmlPostLoginClient expanz_service_XmlPostLoginClient;


