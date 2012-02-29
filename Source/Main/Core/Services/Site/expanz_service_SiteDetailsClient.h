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
#import "expanz_service_SiteDetailsClientDelegate.h"

@class expanz_model_ActivityInstance;
@class expanz_service_CreateActivityRequest;
@class expanz_service_DeltaRequest;
@class expanz_service_MethodInvocationRequest;
@class expanz_service_FileRequest;

@protocol expanz_service_SiteDetailsClient<NSObject>

- (void) listAvailableSitesWith:(id<expanz_service_SiteDetailsClientDelegate>)delegate;

- (void) listActivitiesForSite:(NSString*)site with:(id<expanz_service_SiteDetailsClientDelegate>)delegate;

@end
