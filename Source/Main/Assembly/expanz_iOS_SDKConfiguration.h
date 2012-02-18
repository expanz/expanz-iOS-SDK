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


@interface expanz_ios_SdkConfiguration : NSObject

@property(nonatomic, strong, readonly) NSString* baseUrl;
@property(nonatomic, strong, readonly) NSString* preferredSite;
@property(nonatomic, strong, readonly) NSString* userType;


+ (expanz_ios_SdkConfiguration*) globalConfiguration;

+ (void) setGlobalConfiguration:(expanz_ios_SdkConfiguration*)configuration;

+ (void) clearGlobalConfiguration;

+ (void) setConfigurationFile:(NSString*)fileName;

- (id) initWithBaseUrl:(NSString*)url preferredSite:(NSString*)site userType:(NSString*)userType;

- (id) initWithXmlString:(NSString*)configXml;

- (NSURL*) createSessionServiceUrl;

- (NSURL*) execXServiceUrl;

- (NSURL*) getBlobServiceUrl;

- (void) setConfigurationFile:(NSString*)fileName;

@end

/* ================================================================================================================== */
@compatibility_alias SdkConfiguration expanz_ios_SdkConfiguration;