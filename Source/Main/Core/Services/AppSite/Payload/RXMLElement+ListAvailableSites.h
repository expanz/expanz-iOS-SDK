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
#import "../../../../../../Dependencies/External/RaptureXML/RXMLElement+ListAvailableSites+ListAvailableSites+ListAvailableSites.h"

@class expanz_model_AppSite;
@class expanz_model_SiteList;

@interface RXMLElement (ListAvailableSites)

- (expanz_model_SiteList*) asSiteList;

- (expanz_model_AppSite*) asAppSite;

@end