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
#import "ExpanzActivityClient.h"
#import "expanz_service_AbstractServiceClient.h"

@interface expanz_service_DefaultActivityClient : AbstractServiceClient<ExpanzActivityClient>

@property(nonatomic, strong, readonly) NSString* serviceUrl;

- (id) initWithServiceUrl:(NSString*)serviceUrl;

@end

/* ================================================================================================================== */
@compatibility_alias DefaultActivityClient expanz_service_DefaultActivityClient;
