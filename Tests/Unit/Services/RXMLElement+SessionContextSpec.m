////////////////////////////////////////////////////////////////////////////////
//
//  EXPANZ
//  Copyright 2008-2011 EXPANZ
//  All Rights Reserved.
//
//  NOTICE: Expanz permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "../../../Source/Main/Core/Services/Login/Payload/RXMLElement+SessionContext.h"
#import "expanz_model_SessionContext.h"


SPEC_BEGIN(RXMLElement_SessionContextSpec)


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
        
        SessionContext* sessionContext = [element asSessionContext];
        [[sessionContext sessionToken] shouldNotBeNil];
    });
        
});


describe(@"Valid XML with a warning", ^{
    it(@"Should return a SessionContext with the warning flag set.", ^{
        RXMLElement* element = [RXMLElement elementFromXMLString:kXmlResponseWithWarning]; 
        SessionContext* sessionContext = [element asSessionContext];
        [[sessionContext sessionToken] shouldNotBeNil];
        [[theValue([sessionContext hasWarning]) should] beYes];
        [[[sessionContext message] should] equal:@"Existing session abandoned [19:19]&#xD;"];                
    });

});


describe(@"Valid XML with an error", ^{
    
    it(@"should return a SessionContext with the error flag set.", ^{
        RXMLElement* element = [RXMLElement elementFromXMLString:kXmlResponseWithError]; 
        SessionContext* sessionContext = [element asSessionContext];
        [[theValue([sessionContext hasError]) should] beYes];
        [[[sessionContext message] should] equal:@"Unknown User"];
    });  

});



describe(@"Attempting to instantiate a SessionContext from invalid XML", ^{

    it(@"should throw NSException if the xml root element is not CreateSessionXResponse", ^{
        
        @try {
            RXMLElement* element = [RXMLElement elementFromXMLString:@"<xml><foobar/></xml>"]; 
            SessionContext* sessionContext = [element asSessionContext];                           
            [sessionContext description]; //Suppress unused variable warning. 
            [NSException raise:@"Should have thrown exception" format:@"Assertion failed."];
        }
        @catch(NSException* exception) {
            [[[exception name] should] equal:NSInvalidArgumentException];
        }
    });
    
    it(@"should throw NSException if the contains neither a token nor error message.", ^{
        
        @try {
            RXMLElement* element = [RXMLElement elementFromXMLString:@"<CreateSessionXResponse/>"]; 
            SessionContext* sessionContext = [element asSessionContext];                           
            [sessionContext description]; //Suppress unused variable warning. 
            [NSException raise:@"Should have thrown exception" format:@"Assertion failed."];
        }
        @catch(NSException* exception) {
            [[[exception name] should] equal:NSInvalidArgumentException];
        }
        
    });

});


SPEC_END





