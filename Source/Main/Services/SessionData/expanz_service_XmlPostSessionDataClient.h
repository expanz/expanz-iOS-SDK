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
#import "expanz_service_XmlPostWebService.h"
#import "expanz_service_SessionDataClient.h"

@interface expanz_service_XmlPostSessionDataClient : XmlPostWebService<expanz_service_SessionDataClient>

@end

/* ================================================================================================================== */
@compatibility_alias XmlPostSessionDataClient expanz_service_XmlPostSessionDataClient;
