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


#import "ExpanzActivityStyle.h"


@implementation NSString (ExpanzActivityStyle)

- (ExpanzActivityStyle)asExpanzActivityStyle {
    if ([[self lowercaseString] isEqualToString:@"browse"]) {
        return ActivityStyleBrowse;
    }
    else {
        return ActivityStyleDetail;
    }
}


@end
