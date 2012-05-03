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
#import "ExpanzAbstractServiceClientDelegate.h"

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

- (void) dispatchErrorWith:(id<ExpanzAbstractServiceClientDelegate>)delegate statusCode:(NSInteger)statusCode
                  userInfo:(NSString*)userInfo {

    [delegate requestDidFailWithError:[NSError errorWithDomain:NSStringFromClass([self class]) code:statusCode
                                         userInfo:[NSDictionary dictionaryWithObject:userInfo forKey:@"response"]]];
}


@end
