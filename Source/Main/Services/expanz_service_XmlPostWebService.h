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
#import <LRResty/LRResty.h>
#import "xml_Serializable.h"

@class expanz_iOS_SDKConfiguration;
@protocol expanz_ui_SystemEventReporter;


/**
 * Abstract for Expanz XML post style web services. 
 */
@interface expanz_service_XmlPostWebService : NSObject

@property(nonatomic, strong) NSURL* serviceUrl;
@property(nonatomic, strong) LRRestyClient* httpClient;

- (id) initWithServiceUrl:(NSURL*)serviceUrl;

- (NSDictionary*) requestHeaders;

@end

/* ================================================================================================================== */
@compatibility_alias XmlPostWebService expanz_service_XmlPostWebService;