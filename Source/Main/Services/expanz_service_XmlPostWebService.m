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

@synthesize request = _request;

/* ================================================== Constructors ================================================== */
- (id) initWithRequest:(ASIFormDataRequest*)request {
    self = [super init];
    if (self) {
        _request = [request retain];
        [_request addRequestHeader:@"Content-Type" value:@"text/xml"];   
    }  
    return self;
}

- (void) addPayload:(id<xml_Serializable>)xmlable {
    LogDebug(@"Sending request: %@", [xmlable toXml]);
    [_request appendPostData:[[xmlable toXml] dataUsingEncoding:NSUTF8StringEncoding]];
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_request release];
    [super dealloc];
}

@end
