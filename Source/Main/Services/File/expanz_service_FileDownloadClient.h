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

#import "expanz_service_FileDownloadClientDelegate.h"
#import "expanz_service_FileDownloadClientDelegate.h"

@class expanz_service_FileDownloadRequest;
@class expanz_service_FileRequest;


@protocol expanz_service_FileDownloadClient<NSObject>

- (void)sendFileRequestWith:(expanz_service_FileRequest*)fileRequest
                   delegate:(id <expanz_service_FileDownloadClientDelegate>)delegate;

- (void) downloadFileWith:(expanz_service_FileDownloadRequest*)downloadRequest
                 delegate:(id<expanz_service_FileDownloadClientDelegate>)delegate;

@end