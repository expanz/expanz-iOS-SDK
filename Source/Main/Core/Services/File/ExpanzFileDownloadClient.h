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

#import "ExpanzAbstractServiceClientDelegate.h"

@class expanz_service_FileDownloadRequest;
@class expanz_service_FileRequest;
@class expanz_model_ResourceCollection;


@protocol ExpanzFileDownloadClientDelegate<ExpanzAbstractServiceClientDelegate>

@optional

- (void) requestDidFinishWithResourceCollection:(expanz_model_ResourceCollection*)collection;
- (void) requestDidFinishWithData:(NSData*)data;

@end
/* ================================================================================================================== */


@protocol ExpanzFileDownloadClient<NSObject>

- (void)sendFileRequestWith:(expanz_service_FileRequest*)fileRequest
                   delegate:(id <ExpanzFileDownloadClientDelegate>)delegate;

- (void) downloadFileWith:(expanz_service_FileDownloadRequest*)downloadRequest
                 delegate:(id<ExpanzFileDownloadClientDelegate>)delegate;

@end