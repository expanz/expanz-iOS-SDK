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

#import "SpecHelper.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_service_SessionDataRequest.h"


SPEC_BEGIN(SessionDataRequestSpec)

#define kSessionDataRequestXml @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><GetSessionData/></ESA>\
</xml><sessionHandle>abcd1234</sessionHandle></ExecX>"

describe(@"Serves as the contract for a request to GetSessionData service method", ^{
    
    it(@"should provide an immutable session token property", ^{
        SessionDataRequest* sessionDataRequest = [[SessionDataRequest alloc] initWithSessionToken:@"1234"];
        assertThat(sessionDataRequest.sessionToken, equalTo(@"1234"));
    });
    
    it(@"should be able to return an xml version of itself", ^{
        SessionDataRequest* sessionDataRequest = [[SessionDataRequest alloc] initWithSessionToken:@"abcd1234"];
        NSString* xml = [sessionDataRequest toXml];
        assertThat(xml, equalTo(kSessionDataRequestXml));
        [sessionDataRequest release];        
    });
});


SPEC_END