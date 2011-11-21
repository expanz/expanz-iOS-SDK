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

#import <Objection-iOS/Objection.h>
#import "expanz_service_XmlPostSessionDataClient.h"
#import "RXMLElement+SessionData.h"
#import "expanz_service_SessionDataRequest.h"


@implementation expanz_service_XmlPostSessionDataClient


/* ================================================ Interface Methods =============================================== */

- (void) retrieveSessionDataWith:(SessionDataRequest*)sessionDataRequest 
                        delegate:(id<expanz_service_SessionDataClientDelegate>)delegate {
    
    [self addPayload:sessionDataRequest];
    
    [self.request setCompletionBlock:^{       
        RXMLElement* response = [RXMLElement elementFromXMLString:[self.request responseString]];
        [delegate requestDidFinishWithMenu:[[response child:@"ExecXResult.ESA.Menu"] asMenu]];
    }];
    
    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[self.request error]]; 
    }];
    [self.request startAsynchronous];
}


@end
