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


#import "expanz_service_XmlPostActivityClient.h"
#import "expanz_service_ActivityClientDelegate.h"
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_DeltaRequest.h"
#import "expanz_service_FileRequest.h"
#import "RXMLElement+ActivityInstance.h"
#import "expanz_service_MethodInvocationRequest.h"


@interface expanz_service_XmlPostActivityClient (private)

- (void) doRequestWith:(id<xml_Serializable>)xmlPayload
           forDelegate:(id<expanz_service_ActivityClientDelegate>)delegate;

@end


@implementation expanz_service_XmlPostActivityClient



/* ================================================ Interface Methods =============================================== */
- (void) createActivityWith:(CreateActivityRequest*)activityRequest
                   delegate:(id<expanz_service_ActivityClientDelegate>)delegate {

    [self doRequestWith:activityRequest forDelegate:delegate];
}

- (void) sendDeltaWith:(DeltaRequest*)deltaRequest
              delegate:(id<expanz_service_ActivityClientDelegate>)delegate {

    [self doRequestWith:deltaRequest forDelegate:delegate];
}

- (void) sendFileRequestWith:(expanz_service_FileRequest*)fileRequest
                    delegate:(id<expanz_service_ActivityClientDelegate>)delegate {

    [self doRequestWith:fileRequest forDelegate:delegate];
}


- (void) sendMethodInvocationWith:(expanz_service_MethodInvocationRequest*)methodRequest
                         delegate:(id<expanz_service_ActivityClientDelegate>)delegate {

    [self doRequestWith:methodRequest forDelegate:delegate];
}


/* ================================================== Private Methods =============================================== */
- (void) doRequestWith:(id<xml_Serializable>)xmlPayload
           forDelegate:(id<expanz_service_ActivityClientDelegate>)delegate {

    [self newRequestWithPayload:xmlPayload];

    [self.request setCompletionBlock:^{
        LogDebug(@"Response: %@, ", [self.request responseString]);
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
