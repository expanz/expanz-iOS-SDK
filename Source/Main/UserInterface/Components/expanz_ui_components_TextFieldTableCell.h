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


@interface expanz_ui_components_TextFieldTableCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, retain) IBOutlet UITextField* textField;

- (id) initWithReuseIdentifier:(NSString*)reuseIdentifier; 

@end
/* ================================================================================================================== */
@compatibility_alias TextFieldTableCell expanz_ui_components_TextFieldTableCell;
