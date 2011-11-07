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
#import "ASIFormDataRequest.h"
#import "RXMLElement+SessionContext.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_model_SessionContext.h"
#import "expanz_service_XmlPostLoginClient.h"


@implementation expanz_service_XmlPostLoginClient


/* ================================================ Interface Methods =============================================== */


- (void) createSessionWith:(SessionRequest*)sessionRequest delegate:(id<expanz_service_LoginClientDelegate>)delegate {
    [self addPayload:sessionRequest];
    
    [self.request setCompletionBlock:^{
        RXMLElement* element = [RXMLElement elementFromXMLString:[self.request responseString]];
        [delegate requestDidFinishWithSessionContext:[element asSessionContext]];                          
    }];
    
    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[self.request error]]; 
    }];
    [self.request startAsynchronous];
}


@end
