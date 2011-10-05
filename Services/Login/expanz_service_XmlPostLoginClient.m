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
#import "JBPackageVoodoo.h"
#import "ASIFormDataRequest.h"


@implementation expanz_service_XmlPostLoginClient

objection_register(expanz_service_XmlPostLoginClient)


/* ================================================== Constructors ================================================== */

+ (id) loginClient {
	return [[[self alloc] init] autorelease];
}


- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

/* ================================================ Interface Methods =============================================== */



- (void) createSessionWith:(SessionRequest*)sessionRequest delegate:(id<expanz_service_LoginClientDelegate>)delegate {
    
    NSURL *url = [NSURL URLWithString:kCreateSessionUrl];    
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL: url];   
    [request addRequestHeader:@"Content-Type" value:@"text/xml"]; 
    [request appendPostData:[[sessionRequest toXml] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setCompletionBlock:^{
        SessionContextHolder* contextHolder = [SessionContextHolder fromXml:[request responseString]];
        [delegate performSelector:@selector(requestDidFinishWithSessionContext:) withObject:contextHolder];        
    }];
    
    [request setFailedBlock:^{
        [delegate performSelector:@selector(requestDidFailWithError:) withObject:[request error]]; 
    }];
    [request startAsynchronous];
        
}
    



@end
