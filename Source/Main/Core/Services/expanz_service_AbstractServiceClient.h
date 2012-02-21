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

@class expanz_utils_SdkConfiguration;
@protocol expanz_ui_SystemEventReporter;


/**
 * Abstract for Expanz XML post style web services. 
 */
@interface expanz_service_AbstractServiceClient : NSObject

@property(nonatomic, strong) LRRestyClient* httpTransport;

- (NSDictionary*) requestHeaders;

@end

/* ================================================================================================================== */
@compatibility_alias AbstractServiceClient expanz_service_AbstractServiceClient;