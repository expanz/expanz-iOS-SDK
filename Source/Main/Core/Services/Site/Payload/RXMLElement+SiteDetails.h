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
#import "RXMLElement.h"

@class expanz_model_ActivityMenu;
@class expanz_model_SiteList;
@class expanz_model_AppSite;
@class expanz_model_ActivitySchema;

@interface RXMLElement (ListActivitiesForSite)

- (expanz_model_SiteList*) asSiteList;

- (expanz_model_AppSite*) asAppSite;

- (expanz_model_ActivityMenu*) asActivityMenu;

- (expanz_model_ActivitySchema*) asActivitySchema;


@end