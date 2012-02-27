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
#import "expanz_service_AbstractServiceClientDelegate.h"

@class expanz_model_ActivityInstance;
@class expanz_model_SiteList;
@class expanz_model_ActivityList;

@protocol expanz_service_SiteClientDelegate<expanz_service_AbstractServiceClientDelegate>

- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList;

- (void) requestDidFinishWithActivityList:(expanz_model_ActivityList*)activityList;

@end