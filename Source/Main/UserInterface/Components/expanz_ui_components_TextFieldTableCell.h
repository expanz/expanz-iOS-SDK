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

#import <UIKit/UIKit.h>

/**
* Adds a text field on the right of the table cell, making it an editable control.
*/
@interface expanz_ui_components_TextFieldTableCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, strong) IBOutlet UITextField* textField;

- (id) initWithReuseIdentifier:(NSString*)reuseIdentifier; 

@end
/* ================================================================================================================== */
@compatibility_alias TextFieldTableCell expanz_ui_components_TextFieldTableCell;
