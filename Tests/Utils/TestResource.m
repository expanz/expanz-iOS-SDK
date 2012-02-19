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
    
    NSRange lastDot = [name rangeOfString:@"." options:NSBackwardsSearch];
    if (lastDot.location != NSNotFound) {
        NSString* resource = [name substringToIndex:lastDot.location];
        NSString* type = [name substringFromIndex:lastDot.location + 1];
        LogDebug(@"Resource: %@.%@", resource, type);
        NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:resource ofType:type];
        return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    }
    else {
        NSString* filePath = [[NSBundle bundleForClass:[self class]] pathForResource:name ofType:nil];
        return [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    }
}


@end