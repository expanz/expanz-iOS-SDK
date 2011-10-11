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

@implementation expanz_service_XmlPostActivityClient

objection_register(expanz_service_XmlPostActivityClient)

/* ================================================ Interface Methods =============================================== */

- (void) createActivityWith:(CreateActivityRequest*)activityRequest 
                   delegate:(id<expanz_service_CreateActivityClientDelegate>)delegate {
    
    
    [self.request appendPostData:[[activityRequest toXml] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self.request setCompletionBlock:^{       
        LogDebug(@"Got response: %@", [self.request responseString]);
//        RXMLElement* response = [RXMLElement elementFromXMLString:[self.request responseString]];
//        [delegate requestDidFinishWithMenu:[[response child:@"ExecXResult.ESA.Menu"] asMenu]];
    }];
    
    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[self.request error]]; 
    }];
    [self.request startAsynchronous];

    
    
    
}


@end
