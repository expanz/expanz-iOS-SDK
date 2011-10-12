#import "SpecHelper.h"
#import "OCMock/OCMock.h"
#import "RXMLElement+SessionContextHolder.h"


SPEC_BEGIN(SessionContextHolderSpec)


#define kSessionRequestResponse @"<CreateSessionXResponse xmlns=\"http://www.expanz.com/ESAService\">\
<CreateSessionXResult>net.tcp://127.0.0.1:8198/SessionManager1#634530077119838630:30</CreateSessionXResult>"

#define kXmlResponseWithWarning @"<CreateSessionXResponse xmlns=\"http://www.expanz.com/ESAService\">\
<CreateSessionXResult>net.tcp://127.0.0.1:8198/SessionManager1#634530077119838630:30</CreateSessionXResult>\
<errorMessage>Existing session abandoned [19:19]&#xD;</errorMessage></CreateSessionXResponse>"

#define kXmlResponseWithError @"<CreateSessionXResponse xmlns=\"http://www.expanz.com/ESAService\">\
<CreateSessionXResult/><errorMessage>Unknown User</errorMessage></CreateSessionXResponse>"


describe(@"Valid XML", ^{
    
    
    it(@"should return a SessionContext holder instance, which holds the session token", ^{
        RXMLElement* element = [RXMLElement elementFromXMLString:kSessionRequestResponse]; 
        
        SessionContextHolder* sessionContextHolder = [element asSessionContextHolder];
        assertThat([sessionContextHolder sessionToken], notNilValue());
    });
        
});


describe(@"Valid XML with a warning", ^{
    it(@"Should return a SessionContextHolder with the warning flag set.", ^{
        RXMLElement* element = [RXMLElement elementFromXMLString:kXmlResponseWithWarning]; 
        SessionContextHolder* sessionContextHolder = [element asSessionContextHolder];
        assertThat(sessionContextHolder.sessionToken, is(notNilValue()));
        assertThatBool(sessionContextHolder.hasWarning, is(equalToBool(YES)));
        assertThat(sessionContextHolder.message, is(equalTo(@"Existing session abandoned [19:19]&#xD;")));        
    });

});


describe(@"Valid XML with an error", ^{
    
    it(@"should return a SessionContextHolder with the error flag set.", ^{
        RXMLElement* element = [RXMLElement elementFromXMLString:kXmlResponseWithError]; 
        SessionContextHolder* sessionContextHolder = [element asSessionContextHolder];
        assertThatBool(sessionContextHolder.hasError, is(equalToBool(YES)));
        assertThat(sessionContextHolder.message, is(equalTo(@"Unknown User")));        
    });  

});



describe(@"Attempting to instantiate a SessionContextHolder from invalid XML", ^{

    it(@"should throw NSException if the xml is root element is not CreateSessionXResult", ^{
        
        @try {
            RXMLElement* element = [RXMLElement elementFromXMLString:@"<xml><foobar/></xml>"]; 
            SessionContextHolder* sessionContextHolder = [element asSessionContextHolder];                           
            [sessionContextHolder description]; //Suppress unused variable warning. 
            [NSException raise:@"Should have thrown exception" format:@"Assertion failed."];
        }
        @catch(NSException* exception) {
            assertThat([exception name], equalTo(ExXmlValidationException));
        }
    });
    
    it(@"should throw NSException if the contains neither a token nor error message.", ^{
        
        @try {
            RXMLElement* element = [RXMLElement elementFromXMLString:@"<CreateSessionXResponse/>"]; 
            SessionContextHolder* sessionContextHolder = [element asSessionContextHolder];                           
            [sessionContextHolder description]; //Suppress unused variable warning. 
            [NSException raise:@"Should have thrown exception" format:@"Assertion failed."];
        }
        @catch(NSException* exception) {
            assertThat([exception name], equalTo(ExXmlValidationException));
        }
        
    });

});


SPEC_END





