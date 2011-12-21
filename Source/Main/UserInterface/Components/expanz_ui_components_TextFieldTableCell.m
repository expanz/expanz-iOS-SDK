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

@synthesize textField = _textField;

/* ================================================== Initializers ================================================== */

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString*)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (id) initWithReuseIdentifier:(NSString*)reuseIdentifier {
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
}


/* ================================================ Interface Methods =============================================== */

- (void) layoutSubviews {
    [super layoutSubviews];
    _textField.frame = CGRectMake(120, 10, 185, 30);
    _textField.adjustsFontSizeToFitWidth = YES;
    _textField.textColor = [UIColor blackColor];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.autocorrectionType = UITextAutocorrectionTypeNo;
    _textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _textField.textAlignment = UITextAlignmentLeft;
    // no clear 'x' button to the right
    _textField.clearButtonMode = UITextFieldViewModeNever;
    _textField.enabled = YES;
    [self addSubview:_textField];
}

@end
