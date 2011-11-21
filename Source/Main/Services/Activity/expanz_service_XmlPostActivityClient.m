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
#import "expanz_service_XmlPostActivityClient.h"
#import "expanz_iOS_SDKExceptions.h"
#import "expanz_service_CreateActivityRequest.h"
#import "RXMLElement+ActivityInstance.h"
#import "expanz_service_DeltaRequest.h"
#import "expanz_service_MethodInvocationRequest.h"


@interface expanz_service_XmlPostActivityClient (private) 

-(void) registerResponseParserFor:(id<expanz_service_ActivityClientDelegate>)delegate;

@end


@implementation expanz_service_XmlPostActivityClient

/* ================================================ Interface Methods =============================================== */
- (void) createActivityWith:(CreateActivityRequest*)activityRequest 
                delegate:(id<expanz_service_ActivityClientDelegate>)delegate {

    [self addPayload:activityRequest];
    [self registerResponseParserFor:delegate];
    [self.request startAsynchronous];
}

- (void) sendDeltaWith:(DeltaRequest*)deltaRequest 
                delegate:(id<expanz_service_ActivityClientDelegate>)delegate {
    
    [self addPayload:deltaRequest]; 
    [self registerResponseParserFor:delegate];    
    [self.request startAsynchronous];
    
}

- (void) sendMethodInvocationWith:(expanz_service_MethodInvocationRequest*)methodRequest
                delegate:(id<expanz_service_ActivityClientDelegate>)delegate {
    
    [self addPayload:methodRequest];
    [self registerResponseParserFor:delegate];
    [self.request startAsynchronous];
}


/* ================================================== Private Methods =============================================== */
- (void) registerResponseParserFor:(id<expanz_service_ActivityClientDelegate>)delegate {
    [self.request setCompletionBlock:^{       
        LogDebug(@"Response: %@, ", [self.request responseString]);
        RXMLElement* responseElement = [RXMLElement elementFromXMLString:[self.request responseString]];                
        RXMLElement* activityElement = [responseElement child:@"ExecXResult.ESA.Activity"]; 
        [delegate requestDidFinishWithActivityInstance:[activityElement asActivityInstance]];
    }];
    
    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[self.request error]]; 
    }];    
}


@end
