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
@property(nonatomic, readonly) NSString* userType;


+ (expanz_iOS_SDKConfiguration*) globalConfiguration;

+ (void) setGlobalConfiguration:(expanz_iOS_SDKConfiguration*)configuration;

+ (void) setConfigurationFile:(NSString*)fileName;

- (id) initWithBaseUrl:(NSString*)url preferredSite:(NSString*)site userType:(NSString*)userType;

- (NSURL*) createSessionServiceUrl;

- (NSURL*) execXServiceUrl;

- (NSURL*) getFileServiceUrl;

@end

/* ================================================================================================================== */
@compatibility_alias SDKConfiguration expanz_iOS_SDKConfiguration;