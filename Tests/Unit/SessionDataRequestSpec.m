#import "SpecHelper.h"
#import "JBPackageVoodoo.h"



SPEC_BEGIN(SessionDataRequestSpec)

#define kSessionDataRequestXml @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><GetSessionData/></ESA>\
</xml><sessionHandle>abcd1234</sessionHandle></ExecX>"

describe(@"Serves as the contract for a request to GetSessionData service method", ^{
    
    it(@"should be able to return an xml version of itself", ^{
        SessionDataRequest* sessionDataRequest = [[SessionDataRequest alloc] initWithSessionToken:@"abcd1234"];
        NSString* xml = [sessionDataRequest toXml];
        assertThat(xml, equalTo(kSessionDataRequestXml));
        
        
    });
});


SPEC_END