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

#import "NSString+ColorConversion.h"

@implementation NSString (ColorConversion)

- (UIColor*) toUIColor {
    unsigned int c;
    if ([self characterAtIndex:0] == '#') {
        [[NSScanner scannerWithString:[self substringFromIndex:1]] scanHexInt:&c];
    }
    else {[[NSScanner scannerWithString:self] scanHexInt:&c];}
    return [UIColor
            colorWithRed:((c & 0xff0000) >> 16) / 255.0 green:((c & 0xff00) >> 8) / 255.0 blue:(c & 0xff) / 255.0
            alpha:1.0];
}

@end