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


#import "expanz_SdkConfiguration.h"
#import <RaptureXML/RXMLElement.h>


@implementation expanz_SdkConfiguration

static SdkConfiguration* _globalConfiguration;

@synthesize baseUrl = _baseUrl;
@synthesize preferredSite = _preferredSite;
@synthesize userType = _userType;


/* ================================================= Class Methods ================================================== */
+ (void) setGlobalConfiguration:(SdkConfiguration*)configuration {
    if (_globalConfiguration != nil) {
        [NSException raise:NSInternalInconsistencyException
                    format:@"The global configuration has already been set. If you really want to reset it call "
                               "[SDKConfiguration clearGlobalConfiguration] first."];
    }
    _globalConfiguration = configuration;
}

+ (void) clearGlobalConfiguration {
    _globalConfiguration = nil;
}

+ (SdkConfiguration*) globalConfiguration {
    return _globalConfiguration;
}

+ (void) setConfigurationFile:(NSString*)fileName {
    NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:nil];
    NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (xmlString == nil) {
        [NSException raise:NSInternalInconsistencyException format:@"Config file named '%@' not found.", fileName];
    }
    SdkConfiguration* configuration = [[SdkConfiguration alloc] initWithXmlString:xmlString];
    [SdkConfiguration setGlobalConfiguration:configuration];
}


/* ================================================== Initializers ================================================== */
- (id) initWithBaseUrl:(NSString*)url preferredSite:(NSString*)site userType:(NSString*)userType {
    self = [super init];
    if (self) {
        _baseUrl = [url copy];
        _preferredSite = [site copy];
        _userType = [userType copy];
        _blobCacheUrl = @"";
    }
    return self;
}

- (id) initWithXmlString:(NSString*)configXml {
    RXMLElement* element = [RXMLElement elementFromXMLString:configXml encoding:NSUTF8StringEncoding];

    NSString* baseUrl = [element attribute:@"URL"];
    NSString* preferredSite = [element attribute:@"preferredSite"];
    NSString* userType = [element attribute:@"userType"] == nil ? @"Primary" : [element attribute:@"userType"];

    return [self initWithBaseUrl:baseUrl preferredSite:preferredSite userType:userType];
}

/* ================================================ Interface Methods =============================================== */
- (NSString*) blobCacheUrl {
    return _blobCacheUrl;
}

- (void) setBlobCacheUrl:(NSString*)blobCacheUrl {
    if (blobCacheUrl != nil) {
        _blobCacheUrl = blobCacheUrl;
    }
}

- (NSString*) createSessionServiceUrl {
    return [NSString stringWithFormat:@"%@/CreateSessionX", _baseUrl];
}

- (NSString*) execXServiceUrl {
    return [NSString stringWithFormat:@"%@/ExecX", _baseUrl];
}

- (NSString*) getBlobServiceUrl {
    return [NSString stringWithFormat:@"%@/GetBlob", _baseUrl];
}

- (NSString*) listAvailableSitesUrl {
    return [NSString stringWithFormat:@"%@/ListAvailableSitesX", _baseUrl];
}

- (NSString*) listActivitiesForSiteUrl {
    return [NSString stringWithFormat:@"%@/ListActivitiesForSiteX", _baseUrl];
}

- (NSString*) schemaForActivityUrl {
    return [NSString stringWithFormat:@"%@/GetSchemaForActivityX", _baseUrl];
}

/**
* Allows setting through user defined runtime attributes, in Interface Builder.
*/
- (void) setConfigurationFile:(NSString*)fileName {
    [SdkConfiguration setConfigurationFile:fileName];
}



/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"SDKConfiguration: url=%@, preferredSite=%@", _baseUrl, _preferredSite];
}


@end