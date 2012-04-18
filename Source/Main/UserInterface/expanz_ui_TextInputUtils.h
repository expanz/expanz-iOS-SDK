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


@interface expanz_ui_TextInputUtils : NSObject

/**
* If the text field will be hidden by the keyboard becoming active, this method causes the view to scroll so that
* the text field appears in the remaining space after the keyboard has been presented.
*/
+ (void) revealFromBeneathKeyboard:(id<UITextInput>)textInputControl;

/**
* Restore the view to it's previous state prior to calling revealFromBeneathKeyboard.
*/
+ (void) restoreBeneathKeyboard:(id<UITextInput>)textInputControl;

/**
* Toolbar for dismissing the keyboard and navigating to the previous/next field.
*/
+ (UIToolbar*) keyboardTools;

/**
* Returns true if this is the text field that currently has focus.
*/
+ (BOOL) isCurrentlyEditing:(id<UITextInput>)textInputControl;

+ (id<UITextInput>) currentlyEditingTextInput;

/**
* Registers this text field as the one that currently has focus.
*/
+ (void) setCurrentlyEditing:(id<UITextInput>)textField;


@end

/* ================================================================================================================== */
@compatibility_alias TextInputUtils expanz_ui_TextInputUtils;