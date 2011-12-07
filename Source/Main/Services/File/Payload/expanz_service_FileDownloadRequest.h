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
#import <Foundation/Foundation.h>
#import "xml_Serializable.h"

@interface expanz_service_FileDownloadRequest : NSObject<xml_Serializable>


@property(nonatomic, readonly) NSString* blobId;
@property(nonatomic, readonly) NSString* activityHandle;
@property(nonatomic, readonly) NSString* sessionToken;
@property(nonatomic, readonly) BOOL isByteArray;

+ (id) withBlobId:(NSString*)blobId isByteArray:(BOOL)isByteArray activityHandle:(NSString*)activityHandle;

- (id) initWithBlobId:(NSString*)blobId isByteArray:(BOOL)isByteArray activityHandle:(NSString*)activityHandle
         sessionToken:(NSString*)sessionToken;

@end

/* ================================================================================================================== */
@compatibility_alias FileDownloadRequest expanz_service_FileDownloadRequest;