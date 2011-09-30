#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


SPEC_BEGIN(SessionContextHolderSpec)

#define kXmlResponseWithError @"<CreateSessionXResponse xmlns=\"http://www.expanz.com/ESAService\">\
<CreateSessionXResult/><errorMessage>Unknown User</errorMessage></CreateSessionXResponse>"


describe(@"Instantiate a SessionContextHolder with the response received from the server", ^{
    
    it(@"should set an error flag session token is null and XML errorMessage element is present.", ^{
        SessionContextHolder* sessionContextHolder = [SessionContextHolder fromXml:kXmlResponseWithError];               
        assertThatBool(sessionContextHolder.hasError, is(equalToBool(YES)));
        assertThat(sessionContextHolder.errorMessage, is(equalTo(@"Unknown User")));
    });  
});




SPEC_END





