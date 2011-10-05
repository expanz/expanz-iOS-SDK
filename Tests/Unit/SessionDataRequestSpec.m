#import "SpecHelper.h"
#import "JBPackageVoodoo.h"



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