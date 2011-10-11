#import "SpecHelper.h"
#import "OCMock/OCMock.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_iOS_SDKExceptions.h"


SPEC_BEGIN(SessionRequestSpec)

/* ================================================================================================================== */
describe(@"Object initialization", ^{
    it(@"should throw NSExcption if initialization fails.", ^{
        SessionRequest* sessionRequest = [[SessionRequest alloc] init];
        id mockRequest = [OCMockObject partialMockForObject:sessionRequest];
        [[mockRequest expect] init];
        @try {
            [sessionRequest initWithUserName:@"demo" password:@"demo3" appSite:@"SALESAPP"];
            [mockRequest verify];        
            [NSException raise:@"AssertionFailed" format:@"Should have thrown exception"];
        }
        @catch(NSException* exception) {
            assertThat([exception name], equalTo(ExObjectInitializationException));
            [sessionRequest release];
        }        
    });
});

/* ================================================================================================================== */
describe(@"Properties", ^{
    it(@"should provide immutable userName, password and appSite properties.", ^{
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                          appSite:@"SALESAPP"];
        
        assertThat(sessionRequest.userName, equalTo(@"demo"));
                        assertThat(sessionRequest.password, equalTo(@"demo3"));
        assertThat(sessionRequest.appSite, equalTo(@"SALESAPP"));
        
        [sessionRequest release];
        
    });
});

/* ================================================================================================================== */
#define kXmlRequest @"<CreateSessionX xmlns=\"http://www.expanz.com/ESAService\"><xml>\
<ESA><CreateSession user=\"demo\" password=\"demo3\" appSite=\"SALESAPP\" authenticationMode=\"Primary\" \
clientVersion=\"iOS 1.0\" schemaVersion=\"2.0\"/></ESA></xml></CreateSessionX>"

describe(@"Serialization.", ^{
        
    it(@"Can be marshalled to XML for passing over the wire.", ^{
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                          appSite:@"SALESAPP"];

        assertThat([sessionRequest toXml], equalTo(kXmlRequest));        
        [sessionRequest release];
    });
                
});




SPEC_END