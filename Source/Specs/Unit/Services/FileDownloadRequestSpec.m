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
#import "expanz_service_FileDownloadRequest.h"

#define kExpectedXml @"<GetBlob xmlns=\"http://www.expanz.com/ESAService\"><sessionHandle>zzzyyy</sessionHandle>\
<activityHandle>1234</activityHandle><blobId>22</blobId><isbyteArray>false</isbyteArray></GetBlob>"

SPEC_BEGIN(FileDownloadRequestSpec)

    describe(@"Object creation", ^{

        it(@"should allow initialization with blobId, isByteArray, activityHandle and session token attribtues", ^{
            FileDownloadRequest* request = [[FileDownloadRequest alloc]
                initWithBlobId:@"22" isByteArray:NO activityHandle:@"1234" sessionToken:@"zzzyyy"];

            assertThat(request, notNilValue());
            assertThat(request.blobId, equalTo(@"22"));
            assertThatBool(request.isByteArray, equalToBool(NO));
            assertThat(request.activityHandle, equalTo(@"1234"));
            assertThat(request.sessionToken, equalTo(@"zzzyyy"));

        });

        it(@"should provide a convenience factory method that emits autoreleased instances.", ^{
            FileDownloadRequest
                * request = [FileDownloadRequest withBlobId:@"22" isByteArray:YES activityHandle:@"1234"];

            assertThat(request, notNilValue());
            assertThat(request.blobId, equalTo(@"22"));
            assertThatBool(request.isByteArray, equalToBool(YES));
            assertThat(request.activityHandle, equalTo(@"1234"));
        });


    });

    describe(@"Xml serialization", ^{

        it(@"should be able to serialize itself to xml, for sending to the remote service", ^{
            FileDownloadRequest* request = [[FileDownloadRequest alloc]
                initWithBlobId:@"22" isByteArray:NO activityHandle:@"1234" sessionToken:@"zzzyyy"];

            LogDebug(@"Xml: %@", [request toXml]);
            assertThat([request toXml], equalTo(kExpectedXml));
        });

    });

    SPEC_END