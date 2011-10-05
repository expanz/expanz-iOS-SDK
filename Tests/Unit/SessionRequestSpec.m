#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


SPEC_BEGIN(SessionRequestSpec)

#define kXmlRequest @"<CreateSessionX xmlns=\"http://www.expanz.com/ESAService\"><xml>\
<ESA><CreateSession user=\"demo\" password=\"demo3\" appSite=\"SALESAPP\" authenticationMode=\"Primary\" \
clientVersion=\"iOS 1.0\" schemaVersion=\"2.0\"/></ESA></xml></CreateSessionX>"

describe(@"Encapsulates the data that needs to be passed to the backend, to create an authenticated session.", ^{
    
    __block SessionRequest* sessionRequest; 
    
    beforeEach(^{
        sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" appSite:@"SALESAPP"];
    });
    
    it(@"should provide immutable userName, password and appSite properties.", ^{
        assertThat(sessionRequest.userName, equalTo(@"demo"));
        assertThat(sessionRequest.password, equalTo(@"demo3"));
        assertThat(sessionRequest.appSite, equalTo(@"SALESAPP"));
    });
    
    it(@"Can be marshalled to XML for passing over the wire.", ^{
        assertThat([sessionRequest toXml], equalTo(kXmlRequest));
    });
    
    afterEach(^{
        [sessionRequest release];
    });
            
});




SPEC_END



  

