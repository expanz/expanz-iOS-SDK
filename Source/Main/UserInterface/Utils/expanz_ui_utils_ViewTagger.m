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

#import "expanz_ui_utils_ViewTagger.h"


@implementation expanz_ui_utils_ViewTagger

+ (NSUInteger) tagForView:(UIView*)view {

    NSUInteger generatedTag;
    if (view.tag == 0) {
        NSScanner* scanner = [NSScanner scannerWithString:[NSString stringWithFormat:@"%p", view]];
        [scanner scanHexInt:&generatedTag];
        [view setTag:generatedTag];
    }
    else {
        generatedTag = view.tag;
    }
    return generatedTag;
}


@end