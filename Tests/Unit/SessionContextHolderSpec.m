#import "SpecHelper.h"
#import "JBPackageVoodoo.h"
#import "OCMock/OCMock.h"


SPEC_BEGIN(SessionContextHolderSpec)


/* ================================================================================================================== */

describe(@"Object initialization", ^{
    it(@"should throw NSExcption if initialization fails.", ^{
        SessionContextHolder* context = [[SessionContextHolder alloc] init];
        id mock = [OCMockObject partialMockForObject:context];
        [[mock expect] init];
        @try {
            [context initWithXml:@"<xml/>"];
            [mock verify];        
            [NSException raise:@"AssertionFailed" format:@"Should have thrown exception"];
        }
        @catch(NSException* exception) {
            assertThat([exception name], equalTo(ExObjectInitializationException));
            [context release];
        }        
    });
});

/* ================================================================================================================== */

#define kSessionRequestResponse @"<CreateSessionXResponse xmlns=\"http://www.expanz.com/ESAService\">\
<CreateSessionXResult>net.tcp://127.0.0.1:8198/SessionManager1#634530077119838630:30</CreateSessionXResult>"

#define kXmlResponseWithWarning @"<CreateSessionXResponse xmlns=\"http://www.expanz.com/ESAService\">\
<CreateSessionXResult>net.tcp://127.0.0.1:8198/SessionManager1#634530077119838630:30</CreateSessionXResult>\
<errorMessage>Existing session abandoned [19:19]&#xD;</errorMessage></CreateSessionXResponse>"


describe(@"Instantiate a SessionContextHolder with with a valid response from the server", ^{
    
    
    it(@"should return a SessionContext holder instance, which holds the session token", ^{
        SessionContextHolder* sessionContextHolder = [SessionContextHolder fromXml:kSessionRequestResponse];
        assertThat([sessionContextHolder sessionToken], notNilValue());
    });
    
    it(@"should set a warning flag if session token exists, but XML errorMessage element is present.", ^{
        SessionContextHolder* sessionContextHolder = [SessionContextHolder fromXml:kXmlResponseWithWarning];
        assertThat(sessionContextHolder.sessionToken, is(notNilValue()));
        assertThatBool(sessionContextHolder.hasWarning, is(equalToBool(YES)));
        assertThat(sessionContextHolder.warningMessage, is(equalTo(@"Existing session abandoned [19:19]&#xD;")));        
    });
    
});

/* ================================================================================================================== */

#define kXmlResponseWithError @"<CreateSessionXResponse xmlns=\"http://www.expanz.com/ESAService\">\
<CreateSessionXResult/><errorMessage>Unknown User</errorMessage></CreateSessionXResponse>"

describe(@"Instantiate a SessionContextHolder containing an error", ^{
    
    it(@"should set an error flag session token is null and XML errorMessage element is present.", ^{
        SessionContextHolder* sessionContextHolder = [SessionContextHolder fromXml:kXmlResponseWithError];               
        assertThatBool(sessionContextHolder.hasError, is(equalToBool(YES)));
        assertThat(sessionContextHolder.errorMessage, is(equalTo(@"Unknown User")));
    });  

});


/* ================================================================================================================== */

describe(@"Attempt to instantiate a SessionContextHolder from invalid XML", ^{

    it(@"should throw NSException if the xml contains neither a session token or an error message.", ^{
        
        @try {
            SessionContextHolder* sessionContextHolder = [SessionContextHolder fromXml:@"<xml><foobar/></xml>"];                           
            [sessionContextHolder description]; //Suppress unused variable warning. 
            [NSException raise:@"AssertionFailed" format:@"Should have thrown exception"];
        }
        @catch(NSException* exception) {
            assertThat([exception name], equalTo(ExXmlValidationException));
        }

    });
});


SPEC_END





