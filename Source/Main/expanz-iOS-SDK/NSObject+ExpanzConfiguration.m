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


#import "NSObject+ExpanzConfiguration.h"
#import "RXMLElement.h"
#import "expanz_iOS_SDKConfiguration.h"


@implementation NSObject (ExpanzConfiguration)

- (void) setExpanzConfiguration:(NSString*)configurationFileName {

    NSString* filePath = [[NSBundle mainBundle] pathForResource:configurationFileName ofType:@"xml"];
    NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (xmlString == nil) {
        [NSException raise:NSInternalInconsistencyException format:@"Configuration file named '%@.xml' not found",
                                                                   configurationFileName];
    }
    RXMLElement* element = [RXMLElement elementFromXMLString:xmlString];

    NSString* baseUrl = [element attribute:@"URL"];
    NSString* preferredSite = [element attribute:@"preferredSite"];

    SDKConfiguration* configuration = [[SDKConfiguration alloc] initWithBaseUrl:baseUrl preferredSite:preferredSite];
    [SDKConfiguration setGlobalConfiguration:configuration];
}


@end