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
#import "expanz_service_SiteClient.h"
#import "expanz_service_AbstractServiceClient.h"

@interface expanz_service_DefaultSiteClient : AbstractServiceClient<expanz_service_SiteClient>

@property(nonatomic, strong, readonly) NSString* serviceUrl;

- (id) initWithServiceUrl:(NSString*)serviceUrl;


@end

/* ================================================================================================================== */
@compatibility_alias DefaultSiteClient expanz_service_DefaultSiteClient;
