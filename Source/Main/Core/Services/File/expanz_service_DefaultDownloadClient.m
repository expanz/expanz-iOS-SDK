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


#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_model_ResourceCollection.h"
#import "expanz_service_DefaultDownloadClient.h"
#import "expanz_service_FileRequest.h"
#import "expanz_service_FileDownloadRequest.h"
#import "RXMLElement.h"
#import "RXMLElement+ActivityInstance.h"
#import "RXMLElement+ResourceCollection.h"


@implementation expanz_service_DefaultDownloadClient

@synthesize fileRequestUrl = _fileRequestUrl;
@synthesize getBlobUrl = _getBlobUrl;


/* ================================================== Initializers ================================================== */
- (id) initWithFileRequestUrl:(NSString*)fileRequestUrl getBlobUrl:(NSString*)getBlobUrl {
    self = [super init];
    if (self) {
        _fileRequestUrl = fileRequestUrl;
        _getBlobUrl = getBlobUrl;
    }
    return self;
}


/* ================================================= Protocol Methods =============================================== */
- (void) sendFileRequestWith:(expanz_service_FileRequest*)fileRequest
                    delegate:(id<expanz_service_FileDownloadClientDelegate>)delegate {

    [self.httpTransport post:_fileRequestUrl payload:[fileRequest toXml] headers:[self requestHeaders]
                   withBlock:^(LRRestyResponse* response) {

                       if (response.status == 200) {
                           LogDebug(@"Response: %@, ", [response asString]);
                           RXMLElement* responseElement = [RXMLElement elementFromXMLString:[response asString]];
                           RXMLElement* activityElement = [responseElement child:@"ExecXResult.ESA.Activity"];
                           RXMLElement* resourceElement = [responseElement child:@"ExecXResult.ESA.Files"];

                           Field* titleField = [[activityElement asActivityInstance] fieldWithId:@"File.Title"];
                           LogDebug("Creating resource collection with title: %@", titleField.value);
                           ResourceCollection
                               * resourceCollection = [resourceElement asResourceCollectionWithTitle:titleField.value];
                           LogDebug(@"Created resource collection: %@", resourceCollection);
                           [delegate requestDidFinishWithResourceCollection:resourceCollection];

                       }
                       else {
                           [super dispatchErrorWith:delegate statusCode:response.status userInfo:[response asString]];
                       }
                   }];
}


- (void) downloadFileWith:(expanz_service_FileDownloadRequest*)downloadRequest
                 delegate:(id<expanz_service_FileDownloadClientDelegate>)delegate {

    [self.httpTransport post:_getBlobUrl payload:[downloadRequest toXml] headers:[self requestHeaders]
                   withBlock:^(LRRestyResponse* response) {

                       if (response.status == 200) {
                           LogDebug(@"Response: %@, ", [response asString]);
                           NSData* data = [response responseData];
                           [delegate requestDidFinishWithData:data];

                       }
                       else {
                           [super dispatchErrorWith:delegate statusCode:response.status userInfo:[response asString]];
                       }
                   }];
}


@end