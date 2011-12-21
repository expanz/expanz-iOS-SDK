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

#import "expanz_iOS_SDKConfiguration.h"
#import "expanz_service_XmlPostFileDownloadClient.h"
#import "RXMLElement+ResourceCollection.h"
#import "expanz_service_FileRequest.h"
#import "expanz_service_FileDownloadRequest.h"


@implementation expanz_service_XmlPostFileDownloadClient


/* ================================================ Interface Methods =============================================== */
- (void) newRequestWithPayload:(id<xml_Serializable>)payload {
    self.request = nil;

    SDKConfiguration* configuration = [SDKConfiguration globalConfiguration];
    if ([payload isKindOfClass:[FileRequest class]]) {
        self.request = [[ASIFormDataRequest alloc] initWithURL:configuration.execXServiceUrl];
    }
    else if ([payload isKindOfClass:[FileDownloadRequest class]]) {
        self.request = [[ASIFormDataRequest alloc] initWithURL:configuration.getBlobServiceUrl];
    }
    
    [self.request addRequestHeader:@"Content-Type" value:@"text/xml"];
    [self.request appendPostData:[[payload toXml] dataUsingEncoding:NSUTF8StringEncoding]];
    LogDebug(@"Sending request: %@", [payload toXml]);
}



/* ================================================= Protocol Methods =============================================== */
- (void) sendFileRequestWith:(expanz_service_FileRequest*)fileRequest
                    delegate:(id<expanz_service_FileDownloadClientDelegate>)delegate {

    [self newRequestWithPayload:fileRequest];
    
    __weak XmlPostFileDownloadClient* client = self; 
    [self.request setCompletionBlock:^{
        LogDebug(@"Response: %@, ", [client.request responseString]);
        RXMLElement* responseElement = [RXMLElement elementFromXMLString:[client.request responseString]];
        RXMLElement* resourceElement = [responseElement child:@"ExecXResult.ESA.Files"];
        [delegate requestDidFinishWithResourceCollection:[resourceElement asResourceCollection]];
    }];

    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[client.request error]];
    }];

    [self.request startAsynchronous];
}


- (void) downloadFileWith:(expanz_service_FileDownloadRequest*)downloadRequest
                 delegate:(id<expanz_service_FileDownloadClientDelegate>)delegate {

    [self newRequestWithPayload:downloadRequest];
    __weak XmlPostFileDownloadClient* client = self; 

    [self.request setCompletionBlock:^{
        LogDebug(@"Response: %@, ", [client.request responseString]);
        NSData* data = [client.request responseData];
        [delegate requestDidFinishWithData:data];
    }];

    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[client.request error]];
    }];
    [self.request startAsynchronous];

}


@end