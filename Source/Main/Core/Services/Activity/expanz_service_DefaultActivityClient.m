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


#import "expanz_service_DefaultActivityClient.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_DeltaRequest.h"
#import "RXMLElement+ActivityInstance.h"
#import "expanz_service_MethodInvocationRequest.h"


@interface expanz_service_DefaultActivityClient (private)

- (void) doRequestWith:(id<xml_Serializable>)xmlPayload
        forDelegate:(id<ExpanzActivityClientDelegate>)delegate;

@end


@implementation expanz_service_DefaultActivityClient

@synthesize serviceUrl = _serviceUrl;

/* ================================================== Initializers ================================================== */
- (id) initWithServiceUrl:(NSString*)serviceUrl {
    self = [super init];
    if (self) {
        _serviceUrl = serviceUrl;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) createActivityWith:(CreateActivityRequest*)activityRequest
        delegate:(id<ExpanzActivityClientDelegate>)delegate {

    [self doRequestWith:activityRequest forDelegate:delegate];
}

- (void) sendDeltaWith:(DeltaRequest*)deltaRequest
        delegate:(id<ExpanzActivityClientDelegate>)delegate {

    [self doRequestWith:deltaRequest forDelegate:delegate];
}

- (void) sendMethodInvocationWith:(expanz_service_MethodInvocationRequest*)methodRequest
        delegate:(id<ExpanzActivityClientDelegate>)delegate {

    [self doRequestWith:methodRequest forDelegate:delegate];
}


/* ================================================== Private Methods =============================================== */
- (void) doRequestWith:(id<xml_Serializable>)xmlPayload
        forDelegate:(id<ExpanzActivityClientDelegate>)delegate {

    [self.httpTransport post:_serviceUrl payload:[xmlPayload toXml] headers:[self requestHeaders]
            withBlock:^(LRRestyResponse* response) {

                if (response.status == 200) {
                    LogDebug(@"Response: %@, ", [response asString]);
                    RXMLElement* responseElement = [RXMLElement elementFromXMLString:[response asString]];
                    RXMLElement* activityElement = [responseElement child:@"ExecXResult.ESA.Activity"];
                    [delegate requestDidFinishWithActivityInstance:[activityElement asActivityInstance]];
                }
                else {
                    [super dispatchErrorWith:delegate statusCode:response.status userInfo:[response asString]];
                }
            }];
}

@end
