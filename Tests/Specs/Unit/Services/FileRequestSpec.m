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

#import "expanz_service_FileRequest.h"

#define kExpectedXml @"<ExecX xmlns=\"http://www.expanz.com/ESAService\"><xml><ESA><Activity activityHandle=\"1234\">\
<Context id=\"22\" Type=\"\" contextObject=\"File\"/><MenuAction defaultAction=\"1\" contextObject=\"File\"/>\
</Activity></ESA></xml><sessionHandle>1234</sessionHandle></ExecX>"

SPEC_BEGIN(FileRequestSpec)

    describe(@"Object creation", ^{

        it(@"should allow initialization with fileId, activityHandle and sessionToken attributes.", ^{

            FileRequest* fileRequest =
                [[FileRequest alloc] initWithFileId:@"22" activityHandle:@"1234" sessionToken:@"xxx1234"];

            [fileRequest shouldNotBeNil];
            [[[fileRequest fileId] should] equal:@"22"];
            [[[fileRequest activityHandle] should] equal:@"1234"];
            [[[fileRequest sessionToken] should] equal:@"xxx1234"];

        });

        it(@"should provide a convenience auto-release factory method.", ^{
            FileRequest* fileRequest = [FileRequest forFileId:@"22" activityHandle:@"1234"];
            [fileRequest shouldNotBeNil];
            [[[fileRequest activityHandle] should] equal:@"1234"];
        });

    });

    describe(@"Xml serialization", ^{

        it(@"should be able to serialize itself to xml", ^{
            FileRequest* fileRequest =
                [[FileRequest alloc] initWithFileId:@"22" activityHandle:@"1234" sessionToken:@"1234"];
            LogDebug(@"Xml: %@", [fileRequest toXml]);
            [[[fileRequest toXml] should] equal:kExpectedXml];
        });

    });

    SPEC_END