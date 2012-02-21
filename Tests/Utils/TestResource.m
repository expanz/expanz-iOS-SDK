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
#import "TestResource.h"


@implementation TestResource

+ (NSString*)withName:(NSString*)name {
    
    NSString* contents; 
    NSRange lastDot = [name rangeOfString:@"." options:NSBackwardsSearch];
    if (lastDot.location != NSNotFound) {
        NSString* resource = [name substringToIndex:lastDot.location];
        NSString* type = [name substringFromIndex:lastDot.location + 1];
        LogDebug(@"Resource: %@.%@", resource, type);
        NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:resource ofType:type];
        contents =  [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];        
    }
    else {
        NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:name ofType:nil];
        contents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    }
    if (contents == nil) {
        [NSException raise:NSInvalidArgumentException format:@"Expected contents of file %@ not to be nil", name];
    }
    return contents;
}


@end