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
#import "expanz_service_XmlPostFileDownloadClient.h"


@implementation expanz_service_XmlPostFileDownloadClient


/* ================================================= Protocol Methods =============================================== */
- (void) downloadFileWith:(expanz_service_FileDownloadRequest*)downloadRequest
                 delegate:(id<expanz_service_FileDownloadClientDelegate>)delegate {
    
    [self.request setCompletionBlock:^{
        NSData* data = [self.request responseData];
        LogDebug(@"Got data!");
        [delegate requestDidFinishWithData:data];
    }];
    
    [self.request setFailedBlock:^{
        [delegate requestDidFailWithError:[self.request error]]; 
    }];
    [self.request startAsynchronous];

}


@end