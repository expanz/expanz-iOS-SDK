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


@interface expanz_iOS_SDKConfiguration : NSObject

@property(nonatomic, readonly) NSString* baseUrl;
@property(nonatomic, readonly) NSString* preferredSite;

+ (void) setGlobalConfiguration:(expanz_iOS_SDKConfiguration*)configuration;

+ (expanz_iOS_SDKConfiguration*) globalConfiguration;

- (id) initWithBaseUrl:(NSString*)url preferredSite:(NSString*)site;

- (NSURL*) createSessionUrl;

- (NSURL*) execUrl;

@end

/* ================================================================================================================== */
@compatibility_alias SDKConfiguration expanz_iOS_SDKConfiguration;