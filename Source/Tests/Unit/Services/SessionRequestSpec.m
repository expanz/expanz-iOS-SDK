#import "SpecHelper.h"
#import "expanz_service_SessionRequest.h"
#import "../../../Main/Assembly/expanz_ios_SdkExceptions.h"


SPEC_BEGIN(SessionRequestSpec)

describe(@"Properties", ^{
    it(@"should provide immutable userName, password and appSite properties.", ^{
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                          appSite:@"SALESAPP" userType:@"Primary"];
        
        assertThat(sessionRequest.userName, equalTo(@"demo"));
                        assertThat(sessionRequest.password, equalTo(@"demo3"));
        assertThat(sessionRequest.appSite, equalTo(@"SALESAPP"));

    });
});

#define kXmlRequest @"<CreateSessionX xmlns=\"http://www.expanz.com/ESAService\"><xml>\
<ESA><CreateSession user=\"demo\" password=\"demo3\" appSite=\"SALESAPP\" authenticationMode=\"Primary\" \
clientVersion=\"iOS 1.0\" schemaVersion=\"2.0\"/></ESA></xml></CreateSessionX>"

describe(@"Serialization.", ^{
        
    it(@"Can be marshalled to XML for passing over the wire.", ^{
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                          appSite:@"SALESAPP" userType:@"Primary"];

        assertThat([sessionRequest toXml], equalTo(kXmlRequest));
    });
                
});




SPEC_END