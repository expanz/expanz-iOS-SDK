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
#import "expanz_service_SessionRequest.h"
#import "expanz_model_SessionContextHolder.h"
#import "expanz_service_XmlPostLoginClient.h"
#import "ASIFormDataRequest.h"


@implementation expanz_service_XmlPostLoginClient

objection_register(expanz_service_XmlPostLoginClient)


/* ================================================ Interface Methods =============================================== */


- (void) createSessionWith:(SessionRequest*)sessionRequest delegate:(id<expanz_service_LoginClientDelegate>)delegate {
    
    [self.request appendPostData:[[sessionRequest toXml] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [self.request setCompletionBlock:^{
        SessionContextHolder* contextHolder = [SessionContextHolder fromXml:[self.request responseString]];
        [delegate performSelector:@selector(requestDidFinishWithSessionContext:) withObject:contextHolder];        
    }];
    
    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[self.request error]]; 
    }];
    [self.request startAsynchronous];
        
}
    



@end
