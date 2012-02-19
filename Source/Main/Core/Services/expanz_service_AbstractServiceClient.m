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

#import "expanz_service_AbstractServiceClient.h"

@implementation expanz_service_AbstractServiceClient

@synthesize httpTransport = _httpTransport;


/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _httpTransport = [LRResty client];
    }
    return self;
}


- (NSDictionary*) requestHeaders {
    return [NSDictionary dictionaryWithObject:@"text/xml" forKey:@"Content-Type"];
}


@end
