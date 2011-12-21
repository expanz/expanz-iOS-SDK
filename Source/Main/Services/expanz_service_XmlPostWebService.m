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

#import "ASIHTTPRequest.h"
#import "expanz_service_XmlPostWebService.h"

@implementation expanz_service_XmlPostWebService

@synthesize serviceUrl = _serviceUrl;
@synthesize request = _request;

/* ================================================== Initializers ================================================== */
- (id) initWithServiceUrl:(NSURL*)serviceUrl {
    self = [super init];
    if (self) {
        _serviceUrl = serviceUrl;
    }
    return self;
}


- (void) newRequestWithPayload:(id<xml_Serializable>)xmlable {
    _request = nil;
    _request = [[ASIFormDataRequest alloc] initWithURL:_serviceUrl];
    [_request addRequestHeader:@"Content-Type" value:@"text/xml"];
    [_request appendPostData:[[xmlable toXml] dataUsingEncoding:NSUTF8StringEncoding]];
    LogDebug(@"Sending request: %@", [xmlable toXml]);
}


@end
