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


#import "expanz_iOS_SDKConfiguration.h"
#import "RXMLElement.h"


@implementation expanz_iOS_SDKConfiguration

static SDKConfiguration* _globalConfiguration;

@synthesize baseUrl = _baseUrl;
@synthesize preferredSite = _preferredSite;

/* ================================================= Class Methods ================================================== */
+ (void) setGlobalConfiguration:(SDKConfiguration*)configuration {
    if (_globalConfiguration != configuration) {
        [_globalConfiguration release];
        _globalConfiguration = [configuration retain];
    }
}

+ (SDKConfiguration*) globalConfiguration {
    return [[_globalConfiguration retain] autorelease];
}

+ (void) setConfigurationFile:(NSString*)fileName {
    NSString* filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (xmlString == nil) {
        [NSException raise:NSInternalInconsistencyException format:@"Configuration file named '%@.xml' not found",
                fileName];
    }
    RXMLElement* element = [RXMLElement elementFromXMLString:xmlString];

    NSString* baseUrl = [element attribute:@"URL"];
    NSString* preferredSite = [element attribute:@"preferredSite"];

    SDKConfiguration* configuration = [[SDKConfiguration alloc] initWithBaseUrl:baseUrl preferredSite:preferredSite];
    [SDKConfiguration setGlobalConfiguration:configuration];
    [configuration release];
}


/* ================================================== Constructors ================================================== */
- (id) initWithBaseUrl:(NSString*)url preferredSite:(NSString*)site {
    self = [super init];
    if (self) {
        _baseUrl = [url retain];
        _preferredSite = [site retain];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSURL*) createSessionUrl {
    NSURL* url = [[NSURL URLWithString:[NSString stringWithFormat:@"%@/CreateSessionX", _baseUrl]] retain];
    LogDebug(@"CreateSession URL: %@", url);
    return url;
}

- (NSURL*) execUrl {
    NSURL* url = [[NSURL URLWithString:[NSString stringWithFormat:@"%@/ExecX", _baseUrl]] retain];
    LogDebug(@"ExecX URL: %@", url);
    return url;
}


/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"SDKConfiguration: url=%@, preferredSite=%@", _baseUrl, _preferredSite];
}

- (void) dealloc {
    [_baseUrl release];
    [_preferredSite release];
    [super dealloc];
}


/* ================================================== Private Methods =============================================== */

/**
* Allows setting through user defined runtime attributes, in Interface Builder.
*/
- (void) setConfigurationFile:(NSString*)fileName {
    [SDKConfiguration setConfigurationFile:fileName];
}

@end