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

#import "expanz_service_XmlPostWebService.h"

@implementation expanz_service_XmlPostWebService

@synthesize serviceUrl = _serviceUrl;
@synthesize httpClient = _httpClient;


/* ================================================== Initializers ================================================== */
- (id) initWithServiceUrl:(NSURL*)serviceUrl {
    self = [super init];
    if (self) {
        _serviceUrl = serviceUrl;
        _httpClient = [LRResty client];
    }
    return self;
}


- (NSDictionary*) requestHeaders {
    return [NSDictionary dictionaryWithObject:@"text/xml" forKey:@"Content-Type"];
}


@end
