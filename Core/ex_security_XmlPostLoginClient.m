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
#import "JBServiceLocator.h"
#import "ASIFormDataRequest.h"


@implementation ex_security_XmlPostLoginClient

objection_register(ex_security_XmlPostLoginClient)





/* ================================================== Constructors ================================================== */

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

/* ================================================ Interface Methods =============================================== */



- (ex_security_SessionContextHolder*) createSessionWith:(SessionRequest*)sessionRequest {
    
    NSURL *url = [NSURL URLWithString:kCreateSessionUrl];    
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL: url];   
    [request addRequestHeader:@"Content-Type" value:@"text/xml"]; 
    [request appendPostData:[[sessionRequest toXml] dataUsingEncoding:NSUTF8StringEncoding]];
        
    [request startSynchronous];
    NSError* error = [request error];
    if (!error) {
        NSString* response = [request responseString];           
        LogDebug(@"Response from CreateSession: %@", response);                
        return [[[SessionContextHolder alloc] init] autorelease];
    }
    return nil;    
}
    



@end
