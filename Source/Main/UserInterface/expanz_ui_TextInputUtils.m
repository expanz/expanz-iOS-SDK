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

#import <CoreGraphics/CoreGraphics.h>
#import "expanz_ui_TextInputUtils.h"

#define radians(degrees) degrees * M_PI / 180
static TextInputUtils* gSharedTextInputUtils;

@interface expanz_ui_TextInputUtils (Private)

- (void) calculateDistanceToScrollFor:(UIView*)textInputView;

- (void) doneEditing;

@end

@implementation expanz_ui_TextInputUtils

@synthesize scrolled = _scrolled;
@synthesize currentlyEditingTextInput = _currentlyEditingTextInput;
@synthesize keyboardTools = _keyboardTools;

/* ================================================= Class Methods ================================================== */
+ (expanz_ui_TextInputUtils*) sharedTextInputUtils {
    if (gSharedTextInputUtils == nil) {
        gSharedTextInputUtils = [[TextInputUtils alloc] init];
    }
    return gSharedTextInputUtils;
}

/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _keyboardTools = [[UIToolbar alloc] initWithFrame:CGRectMake(-320, 156, 320, 44)];
        [_keyboardTools setBarStyle:UIBarStyleBlack];
        [_keyboardTools setTranslucent:YES];
        UIBarButtonItem* flexibleSpaceLeft = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];

        UIBarButtonItem* doneButtonItem = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditing)];
        doneButtonItem.tintColor = _keyboardTools.tintColor;

        [_keyboardTools setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButtonItem, nil]];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (void) revealFromBeneathKeyboard:(id<UITextInput>)textInputControl {
    LogDebug(@"Scrolling to accomodate keyboard");
    UIView* textInputView = textInputControl.textInputView;
    [self calculateDistanceToScrollFor:textInputView];

    if (!_scrolled && _distanceToScrollFrame > 0) {

        _scrolled = YES;

        UIToolbar* keyboardTools = [self keyboardTools];
        CGRect keyboardToolsFrame = keyboardTools.frame;
        keyboardToolsFrame.origin.y += _distanceToScrollFrame;
        [keyboardTools setFrame:keyboardToolsFrame];

        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        CGRect windowFrame = textInputView.window.frame;
        windowFrame.origin.y -= _distanceToScrollFrame;
        [textInputView.window setFrame:windowFrame];

        if (_distanceToScrollContainerView > 0) {
            UIScrollView* containerView = (UIScrollView*) textInputView.superview;
            CGPoint contentOffset = containerView.contentOffset;
            contentOffset.y += _distanceToScrollContainerView;
            containerView.contentOffset = contentOffset;
        }

        [UIView commitAnimations];

    }
}

- (void) restoreBeneathKeyboard:(id<UITextInput>)textInputControl {
    LogDebug(@"Restoring previous position.");

    if (_scrolled) {
        UIView* textInputView = textInputControl.textInputView;

        UIToolbar* keyboardTools = [self keyboardTools];
        CGRect keyboardToolsFrame = keyboardTools.frame;
        keyboardToolsFrame.origin.y -= _distanceToScrollFrame;
        [keyboardTools setFrame:keyboardToolsFrame];

        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
        CGRect viewFrame = textInputView.window.frame;
        viewFrame.origin.y += _distanceToScrollFrame;
        [textInputView.window setFrame:viewFrame];

        if (_distanceToScrollContainerView > 0) {
            UIScrollView* containerView = (UIScrollView*) textInputView.superview;
            CGPoint contentOffset = containerView.contentOffset;
            contentOffset.y -= _distanceToScrollContainerView;
            containerView.contentOffset = contentOffset;
        }

        [UIView commitAnimations];

    }
    _scrolled = NO;
}

- (BOOL) isCurrentlyEditing:(id<UITextInput>)textInputControl {
    return textInputControl == _currentlyEditingTextInput;
}

- (void) showKeyboardUtilsInView:(UIView*)view {

    [view addSubview:_keyboardTools];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationBeginsFromCurrentState:NO];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    CGRect viewFrame = _keyboardTools.frame;
    viewFrame.origin.x += 320;
    [_keyboardTools setFrame:viewFrame];
    [UIView commitAnimations];

}



/* ================================================== Private Methods =============================================== */
- (void) calculateDistanceToScrollFor:(UIView*)textInputView {
    _distanceToScrollFrame = 0;
    _distanceToScrollContainerView = 0;

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
            _distanceToScrollFrame = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
        }
        else {
            _distanceToScrollFrame = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
        }
        if ([textInputView.superview isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*) textInputView.superview;
            NSUInteger scrollHeight = scrollView.contentSize.height;
            NSUInteger currentOffset = scrollView.contentOffset.y;
            CGFloat textInputLower = textInputView.frame.origin.y + textInputView.frame.size.height;
            CGFloat lowerViewCoord = 416 + scrollView.contentOffset.y - TOOLBAR_HEIGHT - MARGIN;
            if (textInputLower > (lowerViewCoord)) {
                _distanceToScrollContainerView = textInputLower - lowerViewCoord;
            }
        }
    }
}

- (void) doneEditing {
    [_keyboardTools removeFromSuperview];
    CGRect viewFrame = _keyboardTools.frame;
    viewFrame.origin.x -= 320;
    [_keyboardTools setFrame:viewFrame];
    [_currentlyEditingTextInput.textInputView resignFirstResponder];
}


@end