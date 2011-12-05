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
#import "expanz_ui_components_TreeDataTableCell.h"


@implementation expanz_ui_components_TreeDataTableCell

@synthesize mainLabel = _mainLabel;
@synthesize subLabel = _subLabel;


/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_mainLabel release];
    [_subLabel release];
    [super dealloc];
}

@end