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
@class expanz_model_ActivityDefinitionList;
@class expanz_model_ActivityMenu;
@class expanz_model_ActivitySchema;

@protocol expanz_service_SiteDetailsClientDelegate<expanz_service_AbstractServiceClientDelegate>

@optional

- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList;

- (void) requestDidFinishWithActivityMenu:(expanz_model_ActivityMenu*)activityMenu;

- (void) requestDidFinishWithActivitySchema:(expanz_model_ActivitySchema*)activitySchema;

@end