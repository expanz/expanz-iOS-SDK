#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


SPEC_BEGIN(XmlPostLoginClientSpec)


describe(@"Manages authenticating with the site manager.", ^{
    
    __block id<ex_security_LoginClient> loginClient; 
    
    beforeEach(^{
        loginClient = [[XmlPostLoginClient alloc] init]; 
    });


    it(@"Can request an access token, using a SessionRequest object.", ^{
        SessionRequest* sesionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                         appSite:@"SALESAPP"]; 
        
        SessionContextHolder* sessionContext = [loginClient createSessionWith:sesionRequest]; 
        assertThat(sessionContext, notNilValue());
        


    });

});




SPEC_END



