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
#import "ExpanzSiteDetailsClient.h"
#import "expanz_service_AbstractServiceClient.h"

@interface expanz_service_DefaultSiteDetailsClient : AbstractServiceClient<ExpanzSiteDetailsClient>

@property(nonatomic, strong, readonly) NSString* listAvailableSitesUrl;
@property(nonatomic, strong, readonly) NSString* listActivitiesForSiteUrl;
@property(nonatomic, strong, readonly) NSString* schemaForActivityUrl;

- (id) initWithListAvailableSitesUrl:(NSString*)listAvailableSitesUrl
        listActivitiesForSiteUrl:(NSString*)listActivitiesForSiteUrl
        schemaForActivityUrl:(NSString*)schemaForActivityUrl;


@end

/* ================================================================================================================== */
@compatibility_alias DefaultSiteDetailsClient expanz_service_DefaultSiteDetailsClient;
