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

#import "expanz_service_SessionRequest.h"


SPEC_BEGIN(SessionRequestSpec)

    describe(@"Properties", ^{
        it(@"should provide immutable userName, password and appSite properties.", ^{
            SessionRequest* sessionRequest = [[SessionRequest alloc]
                initWithUserName:@"demo" password:@"demo3" appSite:@"SALESAPP" userType:@"Primary"];

            [[sessionRequest.userName should] equal:@"demo"];
            [[sessionRequest.password should] equal:@"demo3"];
            [[sessionRequest.appSite should] equal:@"SALESAPP"];

        });
    });

#define kXmlRequest @"<CreateSessionX xmlns=\"http://www.expanz.com/ESAService\"><xml>\
<ESA><CreateSession user=\"demo\" password=\"demo3\" appSite=\"SALESAPP\" authenticationMode=\"Primary\" \
clientVersion=\"iOS 1.0\" schemaVersion=\"2.0\"/></ESA></xml></CreateSessionX>"

    describe(@"Serialization.", ^{

        it(@"Can be marshalled to XML for passing over the wire.", ^{
            SessionRequest* sessionRequest = [[SessionRequest alloc]
                initWithUserName:@"demo" password:@"demo3" appSite:@"SALESAPP" userType:@"Primary"];

            [[[sessionRequest toXml] should] equal:kXmlRequest];
        });

    });


SPEC_END