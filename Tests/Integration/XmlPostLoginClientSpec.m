#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


/* ================================================================================================================== */
#pragma mark Call-back methods for request access token. 

@interface TestLoginClientDelegate : NSObject<expanz_security_LoginClientDelegate>

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
    
    __block id<expanz_security_LoginClient> loginClient; 
    
    beforeEach(^{
        loginClient = [[XmlPostLoginClient alloc] init]; 
    });

    describe(@"Requests an access token, using a SessionRequest instance", ^{
        
        it(@"should return a SessionContextHolder, containing a valid session token, within 5 seconds", ^{
            
            SessionRequest* sessionRequest = [[SessionRequest alloc] initWithUserName:@"demo" password:@"demo3" 
                                                                             appSite:@"SALESAPP"]; 
            
            TestLoginClientDelegate* loginDelegate = [[TestLoginClientDelegate alloc] init];
            [loginClient createSessionWith:sessionRequest delegate:loginDelegate]; 
            
            [NSThread sleepForTimeInterval:5];
            LogDebug(@"Result: %@", [loginDelegate sessionContextHolder]);
            assertThat([loginDelegate sessionContextHolder], isNot(nil));
            [sessionRequest release];
        });
        
        
        it(@"should set an error property when invalid credentials are supplied", ^{
//
        });
    });
    
    


});


SPEC_END





