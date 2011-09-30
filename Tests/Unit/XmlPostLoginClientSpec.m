#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


/* ================================================================================================================== */
#pragma mark Call-back methods for request access token. 

@interface TestLoginClientDelegate : NSObject<ex_security_LoginClientDelegate>

@property (nonatomic, retain) SessionContextHolder* sessionContextHolder;
@property (nonatomic, retain) NSError* error; 

@end

@implementation TestLoginClientDelegate

@synthesize sessionContextHolder = _sessionContextHolder, error = _error;

- (void) requestDidFinishWithSessionContext:(SessionContextHolder*)sessionContext {
    LogDebug(@"Session Token: %@", [sessionContext sessionToken]);
    self.sessionContextHolder = sessionContext;    
}

- (void) requestDidFailWithError:(NSError*)error {
    self.error = error;     
}

@end

/* ================================================================================================================== */
SPEC_BEGIN(XmlPostLoginClientSpec)


describe(@"Manages authenticating with the site manager.", ^{
    
    __block id<ex_security_LoginClient> loginClient; 
    
    beforeEach(^{
        loginClient = [[XmlPostLoginClient alloc] init]; 
    });


    it(@"Can request an access token, using a SessionRequest object.", ^{
        SessionRequest* sesionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                         appSite:@"SALESAPP"]; 
        
        TestLoginClientDelegate* loginDelegate = [[TestLoginClientDelegate alloc] init];
        [loginClient createSessionWith:sesionRequest delegate:loginDelegate]; 
        [NSThread sleepForTimeInterval:2];
        LogDebug(@"Result: %@", [loginDelegate sessionContextHolder]);
        assertThat([loginDelegate sessionContextHolder], isNot(nil));
    });

});


SPEC_END





