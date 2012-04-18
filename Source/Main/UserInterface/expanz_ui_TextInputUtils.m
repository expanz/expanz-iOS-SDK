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

#import "expanz_ui_TextInputUtils.h"

static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
static BOOL gScrolled;

static id<UITextInput> gCurrentlyEditingField;
static UIToolbar* gKeyboardTools;

@interface expanz_ui_TextInputUtils (Private)

+ (CGFloat) distanceToScrollFor:(UIView*)textInputView;

+ (void) doneEditing;

@end

@implementation expanz_ui_TextInputUtils

/* ================================================ Interface Methods =============================================== */
+ (void) revealFromBeneathKeyboard:(id<UITextInput>)textInputControl {
    LogDebug(@"Scrolling to accomodate keyboard");
    UIView* textInputView = textInputControl.textInputView;
    CGFloat distanceToScroll = [self distanceToScrollFor:textInputView];

    if (!gScrolled && distanceToScroll > 0) {

        gScrolled = YES;

        UIToolbar* keyboardTools = [self keyboardTools];
        CGRect keyboardToolsFrame = keyboardTools.frame;
        keyboardToolsFrame.origin.y += distanceToScroll;
        [keyboardTools setFrame:keyboardToolsFrame];

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        CGRect windowFrame = textInputView.window.frame;
        windowFrame.origin.y -= distanceToScroll;
        [textInputView.window setFrame:windowFrame];
        [UIView commitAnimations];

    }
}

+ (void) restoreBeneathKeyboard:(id<UITextInput>)textInputControl {
    LogDebug(@"Restoring previous position.");
    if (gScrolled) {
        UIView* textInputView = textInputControl.textInputView;
        CGFloat distanceToScroll = [self distanceToScrollFor:textInputView];

        UIToolbar* keyboardTools = [self keyboardTools];
        CGRect keyboardToolsFrame = keyboardTools.frame;
        keyboardToolsFrame.origin.y -= distanceToScroll;
        [keyboardTools setFrame:keyboardToolsFrame];

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        CGRect viewFrame = textInputView.window.frame;
        viewFrame.origin.y += distanceToScroll;
        [textInputView.window setFrame:viewFrame];
        [UIView commitAnimations];
    }
    gScrolled = NO;
}

+ (UIToolbar*) keyboardTools {
    if (gKeyboardTools == nil) {
        gKeyboardTools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 156, 320, 44)];
        [gKeyboardTools setBarStyle:UIBarStyleBlack];
        [gKeyboardTools setTranslucent:YES];
        UIBarButtonItem* flexibleSpaceLeft = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        UIBarButtonItem* doneButtonItem = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditing)];
        doneButtonItem.tintColor = gKeyboardTools.tintColor;

        [gKeyboardTools setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButtonItem, nil]];
    }
    return gKeyboardTools;
}

+ (BOOL) isCurrentlyEditing:(id<UITextInput>)textInputControl {
    return textInputControl == gCurrentlyEditingField;
}

+ (id<UITextInput>) currentlyEditingTextInput {
    return gCurrentlyEditingField;
}


+ (void) setCurrentlyEditing:(id<UITextInput>)textField {
    gCurrentlyEditingField = textField;
}

/* ================================================== Private Methods =============================================== */
+ (CGFloat) distanceToScrollFor:(UIView*)textInputView {
    CGFloat animatedDistance = 0;
    CGRect textFieldRect = [textInputView.window convertRect:textInputView.bounds fromView:textInputView];
    if (textFieldRect.origin.y >= 250) {
        CGRect viewRect = [textInputView.window convertRect:textInputView.window.bounds fromView:textInputView.window];
        CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
        CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
        CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
        CGFloat heightFraction = numerator / denominator;
        if (heightFraction < 0.0) {
            heightFraction = 0.0;
        }
        else if (heightFraction > 1.0) {
            heightFraction = 1.0;
        }
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown) {
            animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        }
        else {
            animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
        }
    }
    return animatedDistance;
}

+ (void) doneEditing {
    [[TextInputUtils keyboardTools] removeFromSuperview];
    [gCurrentlyEditingField.textInputView resignFirstResponder];
}

@end