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
#import "ASIFormDataRequest.h"
#import "xml_Serializable.h"

@class expanz_iOS_SDKConfiguration;
@protocol expanz_ui_SystemEventReporter;


/**
 * Abstract for Expanz XML post style web services. 
 */
@interface expanz_service_XmlPostWebService : NSObject

@property (nonatomic, readonly) NSURL* serviceUrl;
@property (nonatomic, retain) ASIFormDataRequest* request;

- (id) initWithServiceUrl:(NSURL*)serviceUrl;

/**
 * Utility method for appending post data to the underlying request. 
 */
- (void) newRequestWithPayload:(id <xml_Serializable>)xmlable;

@end

/* ================================================================================================================== */
@compatibility_alias XmlPostWebService expanz_service_XmlPostWebService;