#import "SpecHelper.h"
#import "JBPackageVoodoo.h"


/* ================================================================================================================== */
#pragma mark Call-back methods for request access token. 

@interface TestLoginClientDelegate : NSObject<expanz_service_LoginClientDelegate>

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
    
    __block XmlPostLoginClient* loginClient; 
    
    beforeEach(^{
        JSObjectionInjector* injector = [JSObjection createInjector:[[[SDKModule alloc] init] autorelease]];
        [JSObjection setGlobalInjector:injector];
        loginClient = [injector getObject:@protocol(expanz_service_LoginClient)];
        
        //ASIFormDataRequest<expanz_service_LoginRequestDispatcher>* dispatcher = [injector getObject:@protocol(expanz_service_LoginRequestDispatcher)];
        //loginClient.loginDispatcher = dispatcher;
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
        
        
    });
    
    


});


SPEC_END





