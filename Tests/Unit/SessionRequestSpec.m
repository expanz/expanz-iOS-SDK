#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


SPEC_BEGIN(SessionRequestSpec)


describe(@"Encapsulates the data that needs to be passed to the backend, to create an authenticated session.", ^{
    
    __block SessionRequest* sessionRequest; 
    
    beforeEach(^{
        sessionRequest = [[SessionRequest alloc] init];
    });
    
    it(@"Can be marshalled to XML for passing over the wire.", ^{
        assertThat([sessionRequest toXml], isNot(equalTo(nil)));
                
    });
        
});




SPEC_END



