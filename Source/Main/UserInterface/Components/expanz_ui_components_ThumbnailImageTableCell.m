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


#import "expanz_ui_components_ThumbnailImageTableCell.h"


@implementation expanz_ui_components_ThumbnailImageTableCell

@synthesize mainLabel = _mainLabel;
@synthesize subLabel = _subLabel;
@synthesize thumbnail = _thumbnail;



/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_mainLabel release];
    [_subLabel release];
    [_thumbnail release];
    [super dealloc];
}

@end