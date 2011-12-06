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
#import "expanz_iOS_SDKConfiguration.h"
#import "expanz_ui_SystemEventReporter.h"

@implementation expanz_service_XmlPostWebService

@synthesize serviceUrl = _serviceUrl;
@synthesize request = _request;

/* ================================================== Constructors ================================================== */
- (id)initWithServiceUrl:(NSURL*)serviceUrl {
    self = [super init];
    if (self) {
        _serviceUrl = [serviceUrl retain];
    }
    return self;
}


- (void) newRequestWithPayload:(id <xml_Serializable>)xmlable {
    [_request release];
    _request = [[ASIFormDataRequest alloc] initWithURL:_serviceUrl];
    [_request addRequestHeader:@"Content-Type" value:@"text/xml"];
    [_request appendPostData:[[xmlable toXml] dataUsingEncoding:NSUTF8StringEncoding]];
    LogDebug(@"Sending request: %@", [xmlable toXml]);
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_serviceUrl release];
    [_request release];
    [_serviceUrl release];
    [super dealloc];
}

@end
