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
#import "JBPackageVoodoo.h"
#import "ASIFormDataRequest.h"


@implementation expanz_service_XmlPostLoginClient

objection_register(expanz_service_XmlPostLoginClient)


@synthesize loginRequest = _loginRequest;


/* ================================================== Constructors ================================================== */

- (id) initWithLoginRequest:(ASIFormDataRequest*)loginRequest {
    self = [self init];   
    if (!self) {
        [NSException raise:kInitializationFailed format:@"Call to super-class initialization failed."];
    }
    _loginRequest = [loginRequest retain];    
    return self;
}



/* ================================================ Interface Methods =============================================== */


- (void) createSessionWith:(SessionRequest*)sessionRequest delegate:(id<expanz_service_LoginClientDelegate>)delegate {
        
    [_loginRequest addRequestHeader:@"Content-Type" value:@"text/xml"]; 
    [_loginRequest appendPostData:[[sessionRequest toXml] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [_loginRequest setCompletionBlock:^{
        SessionContextHolder* contextHolder = [SessionContextHolder fromXml:[_loginRequest responseString]];
        [delegate performSelector:@selector(requestDidFinishWithSessionContext:) withObject:contextHolder];        
    }];
    
    [_loginRequest setFailedBlock:^{
        [delegate performSelector:@selector(requestDidFailWithError:) withObject:[_loginRequest error]]; 
    }];
    [_loginRequest startAsynchronous];
        
}
    



@end
