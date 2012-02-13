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

#import "RXMLElement+SessionContext.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_model_SessionContext.h"
#import "expanz_service_XmlPostLoginClient.h"


@implementation expanz_service_XmlPostLoginClient


/* ================================================= Protocol Methods =============================================== */
- (void) createSessionWith:(SessionRequest*)sessionRequest delegate:(id<expanz_service_LoginClientDelegate>)delegate {

    [self.httpClient post:[self.serviceUrl absoluteString] payload:[sessionRequest toXml] headers:[self requestHeaders]
                withBlock:^(LRRestyResponse* response) {

                    if (response.status == 200) {
                        LogDebug(@"Response: %@, ", [response asString]);
                        RXMLElement* element = [RXMLElement elementFromXMLString:[response asString]];
                        [delegate requestDidFinishWithSessionContext:[element asSessionContext]];
                    }
                    else {
                        NSString* domain = NSStringFromClass([self class]);
                        NSDictionary
                            * userInfo = [NSDictionary dictionaryWithObject:[response asString] forKey:@"response"];
                        NSError* error = [NSError errorWithDomain:domain code:response.status userInfo:userInfo];
                        [delegate requestDidFailWithError:error];
                    }
                }];
}


@end
