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
#import "../expanz_service_AbstractServiceClient.h"
#import "expanz_service_FileDownloadClient.h"

@interface expanz_service_DefaultDownloadClient : expanz_service_AbstractServiceClient<expanz_service_FileDownloadClient>


@property (nonatomic, strong, readonly) NSString* fileRequestUrl;
@property (nonatomic, strong, readonly) NSString* getBlobUrl;


- (id) initWithFileRequestUrl:(NSString*)fileRequestUrl getBlobUrl:(NSString*)getBlobUrl;


@end

/* ================================================================================================================== */
@compatibility_alias DefaultDownloadClient expanz_service_DefaultDownloadClient;