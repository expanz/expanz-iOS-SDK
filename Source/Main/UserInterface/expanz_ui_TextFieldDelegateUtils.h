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


@interface expanz_ui_TextFieldDelegateUtils : NSObject

/**
* If the text field will be hidden by the keyboard becoming active, this method causes the view to scroll so that
* the text field appears in the remaining space after the keyboard has been presented.
*/
+ (void) revealFromBeneathKeyboard:(UITextField*)textField;

/**
* Restore the view to it's previous state prior to calling revealFromBeneathKeyboard.
*/
+ (void) restoreBeneathKeyboard:(UITextField*)textField;

/**
* Returns true if this is the text field that currently has focus.
*/
+ (BOOL) isCurrentlyEditingField:(UITextField*)textField;

+ (UITextField*) currentlyEditingTextField;

/**
* Registers this text field as the one that currently has focus.
*/
+ (void) setCurrentlyEditingField:(UITextField*)textField; 


@end

/* ================================================================================================================== */
@compatibility_alias TextFieldDelegateUtils expanz_ui_TextFieldDelegateUtils;