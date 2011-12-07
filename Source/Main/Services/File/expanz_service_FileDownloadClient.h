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

@class expanz_service_FileDownloadRequest;


@protocol expanz_service_FileDownloadClient

- (void) downloadFileWith:(expanz_service_FileDownloadRequest*)downloadRequest
                 delegate:(id<expanz_service_FileDownloadClientDelegate>)delegate;

@end