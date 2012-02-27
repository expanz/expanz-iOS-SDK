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

#import "expanz_service_AbstractServiceClientDelegate.h"

@class expanz_model_ResourceCollection;

@protocol expanz_service_FileDownloadClientDelegate<expanz_service_AbstractServiceClientDelegate>

- (void) requestDidFinishWithResourceCollection:(expanz_model_ResourceCollection*)collection;
- (void) requestDidFinishWithData:(NSData*)data;

@end