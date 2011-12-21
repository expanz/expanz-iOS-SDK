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

- (void) retrieveSessionDataWith:(SessionDataRequest*)sessionDataRequest 
                        delegate:(id<expanz_service_SessionDataClientDelegate>)delegate {
    
    [self newRequestWithPayload:sessionDataRequest];
    __weak XmlPostSessionDataClient* client = self; 
    
    [self.request setCompletionBlock:^{
        LogDebug(@"Response: %@", [client.request responseString]);
        RXMLElement* response = [RXMLElement elementFromXMLString:[client.request responseString]];
        [delegate requestDidFinishWithMenu:[[response child:@"ExecXResult.ESA.Menu"] asMenu]];
    }];
    
    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[client.request error]]; 
    }];
    [self.request startAsynchronous];
}


@end
