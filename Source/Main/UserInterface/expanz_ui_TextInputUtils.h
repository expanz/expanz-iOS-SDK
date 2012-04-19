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

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;


@interface expanz_ui_TextInputUtils : NSObject {

@private
    BOOL _scrolled;
    UIToolbar* _keyboardTools;
}

@property(nonatomic, readonly) BOOL scrolled;
@property(nonatomic, strong) id<UITextInput> currentlyEditingTextInput;

/**
* Toolbar for dismissing the keyboard and navigating to the previous/next field.
*/
@property(nonatomic, strong, readonly) UIToolbar* keyboardTools;

+ (expanz_ui_TextInputUtils*) sharedTextInputUtils;

/**
* If the text field will be hidden by the keyboard becoming active, this method causes the view to scroll so that
* the text field appears in the remaining space after the keyboard has been presented.
*/
- (void) revealFromBeneathKeyboard:(id<UITextInput>)textInputControl;

/**
* Restore the view to it's previous state prior to calling revealFromBeneathKeyboard.
*/
- (void) restoreBeneathKeyboard:(id<UITextInput>)textInputControl;

/**
* Returns true if this is the field or text view with current focus.
*/
- (BOOL) isCurrentlyEditing:(id<UITextInput>)textInputControl;


@end

/* ================================================================================================================== */
@compatibility_alias TextInputUtils expanz_ui_TextInputUtils;