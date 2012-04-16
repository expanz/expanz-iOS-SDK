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


#import "expanz_service_FileDownloadRequest.h"

#define kExpectedXml @"<GetBlob xmlns=\"http://www.expanz.com/ESAService\"><sessionHandle>zzzyyy</sessionHandle>\
<activityHandle>1234</activityHandle><blobId>22</blobId><isbyteArray>false</isbyteArray></GetBlob>"

SPEC_BEGIN(FileDownloadRequestSpec)

    describe(@"Object creation", ^{

        it(@"should allow initialization with blobId, isByteArray, activityHandle and session token attribtues", ^{
            FileDownloadRequest* request = [[FileDownloadRequest alloc]
                initWithBlobId:@"22" isByteArray:NO activityHandle:@"1234" sessionToken:@"zzzyyy"];

            [request shouldNotBeNil];
            [[[request blobId] should] equal:@"22"];
            [[theValue([request isByteArray]) should] beNo];
            [[[request activityHandle] should] equal:@"1234"];
            [[[request sessionToken] should] equal:@"zzzyyy"];

        });

        it(@"should provide a convenience factory method that emits autoreleased instances.", ^{
            FileDownloadRequest
                * request = [FileDownloadRequest withBlobId:@"22" isByteArray:YES activityHandle:@"1234"];

            [request shouldNotBeNil];
            [[[request blobId] should] equal:@"22"];
            [[theValue([request isByteArray]) should] beYes];
            [[[request activityHandle] should] equal:@"1234"];
        });


    });

    describe(@"Xml serialization", ^{

        it(@"should be able to serialize itself to xml, for sending to the remote service", ^{
            FileDownloadRequest* request = [[FileDownloadRequest alloc]
                initWithBlobId:@"22" isByteArray:NO activityHandle:@"1234" sessionToken:@"zzzyyy"];

            LogDebug(@"Xml: %@", [request toXml]);
            [[[request toXml] should] equal:kExpectedXml];
        });

    });

SPEC_END