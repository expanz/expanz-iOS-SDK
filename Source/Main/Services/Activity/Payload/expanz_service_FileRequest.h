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


@interface expanz_service_FileRequest : NSObject<xml_Serializable>

@property(nonatomic, strong) NSString* fileId;
@property(nonatomic, strong) NSString* activityHandle;
@property(nonatomic, strong) NSString* sessionToken;


+ (id) forFileId:(NSString*)fileId activityHandle:(NSString*)activityHandle;

- (id) initWithFileId:(NSString*)fileId activityHandle:(NSString*)activityHandle sessionToken:(NSString*)sessionToken;

@end

/* ================================================================================================================== */
@compatibility_alias FileRequest expanz_service_FileRequest;