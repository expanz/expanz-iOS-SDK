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


#import "UIScrollView+ContentSizeUtils.h"

@implementation UIScrollView (AutoContentSize)

- (void) setAutosizeContent:(BOOL)autosizeContent {

    if (autosizeContent) {
        CGFloat contentWidth =
                self.frame.size.width == self.superview.frame.size.width ? self.superview.frame.size.width :
                self.frame.size.width + 10;
        CGFloat contentHeight =
                self.frame.size.height == self.superview.frame.size.height ? self.superview.frame.size.height :
                self.frame.size.height + 10;
        self.contentSize = CGSizeMake(contentWidth, contentHeight);
    }
}

@end