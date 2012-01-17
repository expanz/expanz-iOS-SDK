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

#import "expanz_ui_components_TextFieldTableCell.h"


@implementation expanz_ui_components_TextFieldTableCell


@synthesize label = _label;
@synthesize textField = _textField;

/* ================================================== Initializers ================================================== */

- (id) init {
    self = [super init];
    if (self) {
        LogDebug(@"Initializing text field table cell");
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


@end
