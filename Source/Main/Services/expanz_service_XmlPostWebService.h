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


/**
 * Abstract for Expanz XML post style web services. 
 */
@interface expanz_service_XmlPostWebService : NSObject


@property (nonatomic, retain) ASIFormDataRequest* request; 

/**
 * Initializes the request using an ASIFormDataRequest that has been mapped to the service endpoint. 
 */
- (id) initWithRequest:(ASIFormDataRequest*)request;

/**
 * Utility method for appending post data to the underlying request. 
 */
- (void) addPayload:(id<xml_Serializable>)xmlable; 

@end

/* ================================================================================================================== */
@compatibility_alias XmlPostWebService expanz_service_XmlPostWebService;