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
#import "NSString+Contains.h"


@implementation NSString (Contains)

- (BOOL) contains:(NSString*)subString {
    return [self rangeOfString:subString].location != NSNotFound;
}

@end