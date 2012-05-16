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

#import <Foundation/Foundation.h>

static int const CONTENT_MARGIN = 50;
static short const PORTRAIT_WIDTH = 320;
static short const PORTRAIT_HEIGHT = 416;

@interface UIScrollView (AutoContentSize)

- (void) setAutoContentSizePortrait:(BOOL)autosizeContent;

- (void) setAutoContentSizePortraitHorizontal:(BOOL)autosizeContent;

- (void) setAutoContentSizePortraitVertical:(BOOL)autosizeContent;


@end