#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


SPEC_BEGIN(SessionDataRequestSpec)

describe(@"Serves as the contract for a request to GetSessionData service method", ^{
    
    it(@"should be able to return an xml version of itself", ^{
        SessionDataRequest* sessionDataRequest = [[SessionDataRequest alloc] initWithSessionToken:@"abcd1234"];
        
        
    });
});


SPEC_END