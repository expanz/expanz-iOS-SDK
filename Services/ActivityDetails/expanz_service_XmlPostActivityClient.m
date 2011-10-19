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

#import "Objection.h"
#import "expanz_service_XmlPostActivityClient.h"
#import "expanz_iOS_SDKExceptions.h"
#import "expanz_service_CreateActivityRequest.h"
#import "RXMLElement+ActivityInstance.h"

@implementation expanz_service_XmlPostActivityClient


/* ================================================ Interface Methods =============================================== */

- (void) createActivityWith:(CreateActivityRequest*)activityRequest 
                   delegate:(id<expanz_service_CreateActivityClientDelegate>)delegate {
    
    [self addPayload:activityRequest];
    
    [self.request setCompletionBlock:^{       
        RXMLElement* responseElement = [RXMLElement elementFromXMLString:[self.request responseString]];                
        RXMLElement* activityElement = [responseElement child:@"ExecXResult.ESA.Activity"]; 
        [delegate requestDidFinishWithActivityInstance:[activityElement asActivityInstance]];
    }];
    
    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[self.request error]]; 
    }];
    [self.request startAsynchronous];
}


@end
