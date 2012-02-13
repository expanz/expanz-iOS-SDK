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

#import "expanz_service_SessionDataClientDelegate.h"
#import "expanz_service_SessionDataRequest.h"
#import "RXMLElement+SessionData.h"
#import "expanz_service_XmlPostSessionDataClient.h"


@implementation expanz_service_XmlPostSessionDataClient


/* ================================================ Interface Methods =============================================== */

- (void) retrieveSessionDataWith:(SessionDataRequest*)request
                        delegate:(id<expanz_service_SessionDataClientDelegate>)delegate {

    [self.httpClient post:[self.serviceUrl absoluteString] payload:[request toXml] headers:[self requestHeaders]
                withBlock:^(LRRestyResponse* response) {

                    if (response.status == 200) {
                        LogDebug(@"Response: %@, ", [response asString]);
                        RXMLElement* element = [RXMLElement elementFromXMLString:[response asString]];
                        [delegate requestDidFinishWithMenu:[[element child:@"ExecXResult.ESA.Menu"] asMenu]];
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
