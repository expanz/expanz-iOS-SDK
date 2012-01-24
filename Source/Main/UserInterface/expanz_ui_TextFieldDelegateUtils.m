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
#import "expanz_ui_TextFieldDelegateUtils.h"

static UITextField* gCurrentlyEditingField;
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 216;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 162;
static CGFloat gAnimatedDistance;
static BOOL gScrolled;

@implementation expanz_ui_TextFieldDelegateUtils


/* ================================================ Interface Methods =============================================== */
+ (void) revealFromBeneathKeyboard:(UITextField*)textField {
    LogDebug(@"Scrolling to accomodate keyboard");
    if (!gScrolled) {
        CGRect textFieldRect = [textField.window convertRect:textField.bounds fromView:textField];
        if (textFieldRect.origin.y >= 250) {
            gScrolled = YES;
            CGRect viewRect = [textField.window convertRect:textField.window.bounds fromView:textField.window];
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
            if (orientation == UIInterfaceOrientationPortrait || orientation ==
                UIInterfaceOrientationPortraitUpsideDown) {
                gAnimatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
            }
            else {
                gAnimatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
            }
            CGRect viewFrame = textField.window.frame;
            viewFrame.origin.y -= gAnimatedDistance;

            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationBeginsFromCurrentState:YES];
            [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
            [textField.window setFrame:viewFrame];
            [UIView commitAnimations];
        }
        else {
            LogDebug(@"Text field is already above keyboard");
        }
    }
}


+ (void) restoreBeneathKeyboard:(UITextField*)textField {
    LogDebug(@"Restoring previous position.");
    if (gScrolled) {
        CGRect viewFrame = textField.window.frame;
        viewFrame.origin.y += gAnimatedDistance;

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        [textField.window setFrame:viewFrame];
        [UIView commitAnimations];
    }
    gScrolled = NO;

}


+ (BOOL) isCurrentlyEditingField:(UITextField*)textField {
    return textField == gCurrentlyEditingField;
}

+ (UITextField*) currentlyEditingTextField {
    return gCurrentlyEditingField;
}


+ (void) setCurrentlyEditingField:(UITextField*)textField {
    gCurrentlyEditingField = textField;

}


@end