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

#import "SpecHelper.h"
#import "expanz_service_FileRequest.h"

#define kExpectedXml @"<ESA sessionHandle=\"1234\"><Activity activityHandle=\"1234\"><Context id=\"22\" Type=\"\" \
contextObject=\"File\"/><MenuAction defaultAction=\"1\" contextObject=\"File\"/></Activity></ESA>"

SPEC_BEGIN(FileRequestSpec)

    describe(@"Object creation", ^{

        it(@"should allow initialization with fileId, activityHandle and sessionToken attributes.", ^{

            FileRequest* fileRequest =
                [[FileRequest alloc] initWithFileId:@"22" activityHandle:@"1234" sessionToken:@"xxx1234"];

            assertThat(fileRequest, notNilValue());
            assertThat(fileRequest.fileId, equalTo(@"22"));
            assertThat(fileRequest.activityHandle, equalTo(@"1234"));
            assertThat(fileRequest.sessionToken, equalTo(@"xxx1234"));
            [fileRequest release];
        });

        it(@"should provide a convenience auto-release factory method.", ^{
            FileRequest* fileRequest = [FileRequest forFileId:@"22" activityHandle:@"1234"];
            assertThat(fileRequest, notNilValue());
            assertThat(fileRequest.activityHandle, equalTo(@"1234"));
        });

    });

    describe(@"Xml serialization", ^{

        it(@"should be able to serialize itself to xml", ^{
            FileRequest* fileRequest =
                [[FileRequest alloc] initWithFileId:@"22" activityHandle:@"1234" sessionToken:@"1234"];
            LogDebug(@"Xml: %@", [fileRequest toXml]);
            assertThat([fileRequest toXml], equalTo(kExpectedXml));
        });

    });

    SPEC_END