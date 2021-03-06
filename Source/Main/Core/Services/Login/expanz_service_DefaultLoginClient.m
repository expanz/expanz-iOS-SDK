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

#import "expanz_service_SessionRequest.h"
#import "expanz_model_SessionContext.h"
#import "expanz_service_DefaultLoginClient.h"
#import "RXMLElement.h"
#import "RXMLElement+SessionContext.h"


@implementation expanz_service_DefaultLoginClient

@synthesize serviceUrl = _serviceUrl;

/* ================================================== Initializers ================================================== */
- (id) initWithServiceUrl:(NSString*)serviceUrl {
    self = [super init];
    if (self) {
        _serviceUrl = serviceUrl;
    }
    return self;
}

/* ================================================= Protocol Methods =============================================== */
- (void) createSessionWith:(SessionRequest*)sessionRequest delegate:(id<ExpanzLoginClientDelegate>)delegate {

    [self.httpTransport post:_serviceUrl payload:[sessionRequest toXml] headers:[self requestHeaders]
            withBlock:^(LRRestyResponse* response) {

                if (response.status == 200) {
                    LogDebug(@"Response: %@, ", [response asString]);
                    RXMLElement* element =
                            [RXMLElement elementFromXMLString:[response asString] encoding:NSUTF8StringEncoding];
                    [delegate requestDidFinishWithSessionContext:[element asSessionContext]];
                }
                else {
                    [super dispatchErrorWith:delegate statusCode:response.status userInfo:[response asString]];
                }
            }];
}


@end
