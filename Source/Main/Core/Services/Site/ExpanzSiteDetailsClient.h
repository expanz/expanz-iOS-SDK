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
#import "ExpanzAbstractServiceClientDelegate.h"

@class expanz_model_ActivityInstance;
@class expanz_service_CreateActivityRequest;
@class expanz_service_DeltaRequest;
@class expanz_service_MethodInvocationRequest;
@class expanz_service_FileRequest;
@class expanz_model_SiteList;
@class expanz_model_ActivityMenu;
@class expanz_model_ActivitySchema;


@protocol ExpanzSiteDetailsClientDelegate<ExpanzAbstractServiceClientDelegate>

@optional

- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList;

- (void) requestDidFinishWithActivityMenu:(expanz_model_ActivityMenu*)activityMenu;

- (void) requestDidFinishWithActivitySchema:(expanz_model_ActivitySchema*)activitySchema;

@end
/* ================================================================================================================== */


@protocol ExpanzSiteDetailsClient<NSObject>

- (void) listAvailableSitesWithDelegate:(id<ExpanzSiteDetailsClientDelegate>)delegate;

- (void) listActivitiesForSite:(NSString*)site withDelegate:(id<ExpanzSiteDetailsClientDelegate>)delegate;

- (void) site:(NSString*)siteId requestSchemaForActivity:(NSString*)activityId
        withDelegate:(id<ExpanzSiteDetailsClientDelegate>)delegate;

@end
