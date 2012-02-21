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
@class expanz_model_ActivityInstance;
@class expanz_model_SiteList;

@protocol expanz_service_SiteClientDelegate<NSObject>

- (void) requestDidFinishWithSiteList:(expanz_model_SiteList*)siteList;
- (void) requestDidFailWithError:(NSError*)error;

@end