#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


SPEC_BEGIN(SessionContextHolderSpec)

#define kXmlResponseWithSessionToken @"<CreateSessionXResponse xmlns=\"http://www.expanz.com/ESAService\">\
<CreateSessionXResult>net.tcp://127.0.0.1:8198/SessionManager1#634530077119838630:30</CreateSessionXResult>\
<errorMessage>Existing session abandoned [19:19]&#xD;</errorMessage></CreateSessionXResponse>"

#define kXmlResponseWithError @"<CreateSessionXResponse xmlns=\"http://www.expanz.com/ESAService\">\
<CreateSessionXResult/><errorMessage>Unknown User</errorMessage></CreateSessionXResponse>"


describe(@"Instantiate a SessionContextHolder with the response received from the server", ^{
    
    it(@"should set a warning flag if session token exists, but XML errorMessage element is present.", ^{
        SessionContextHolder* sessionContextHolder = [SessionContextHolder fromXml:kXmlResponseWithSessionToken];
        assertThat(sessionContextHolder.sessionToken, is(notNilValue()));
        assertThatBool(sessionContextHolder.hasWarning, is(equalToBool(YES)));
        assertThat(sessionContextHolder.warningMessage, is(equalTo(@"Existing session abandoned [19:19]&#xD;")));        
    });
    
    it(@"should set an error flag session token is null and XML errorMessage element is present.", ^{
        SessionContextHolder* sessionContextHolder = [SessionContextHolder fromXml:kXmlResponseWithError];               
        assertThatBool(sessionContextHolder.hasError, is(equalToBool(YES)));
        assertThat(sessionContextHolder.errorMessage, is(equalTo(@"Unknown User")));
    });  
});




SPEC_END





