#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


SPEC_BEGIN(SessionRequestSpec)

#define kXmlResponse @"<CreateSessionX xmlns=\"http://www.expanz.com/ESAService\"><xml>\
<ESA><CreateSession user=\"demo\" password=\"demo3\" appSite=\"SALESAPP\" authenticationMode=\"Primary\" \
clientVersion=\"iOS 1.0\" schemaVersion=\"2.0\"/></ESA></xml></CreateSessionX>"


describe(@"Encapsulates the data that needs to be passed to the backend, to create an authenticated session.", ^{
    
    
    it(@"Can be marshalled to XML for passing over the wire.", ^{
        
        SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3"
                                                                              appSite:@"SALESAPP"];
        NSString* xml = [sessionRequest toXml]; 
        LogDebug(@"Xml: \n%@", xml);
        assertThat([sessionRequest toXml], equalTo(kXmlResponse));
                
    });
        
});




SPEC_END



