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
#import "expanz_service_ActivityClient.h"
#import "expanz_service_XmlPostWebService.h"

@interface expanz_service_XmlPostActivityClient : XmlPostWebService<expanz_service_ActivityClient>

@property(nonatomic, strong, readonly) NSURL* serviceUrl;

- (id) initWithServiceUrl:(NSURL*)serviceUrl;


@end

/* ================================================================================================================== */
@compatibility_alias XmlPostActivityClient expanz_service_XmlPostActivityClient;
