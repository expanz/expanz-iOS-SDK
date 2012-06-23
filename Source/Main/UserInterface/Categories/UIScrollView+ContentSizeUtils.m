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

- (void) setAutoContentSizePortrait:(BOOL)autosizeContent {
    if (autosizeContent) {
        self.contentSize = CGSizeMake(PORTRAIT_WIDTH + CONTENT_MARGIN, PORTRAIT_HEIGHT + CONTENT_MARGIN);
    }
}

- (void) setAutoContentSizePortraitHorizontal:(BOOL)autosizeContent {
    if (autosizeContent) {
        self.contentSize = CGSizeMake(PORTRAIT_WIDTH + CONTENT_MARGIN, PORTRAIT_HEIGHT);
    }
}

- (void) setAutoContentSizePortraitVertical:(BOOL)autosizeContent {
    if (autosizeContent) {
        self.contentSize = CGSizeMake(PORTRAIT_WIDTH, PORTRAIT_HEIGHT + CONTENT_MARGIN);
    }
}


@end