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

@protocol expanz_ui_SystemEventReporter <NSObject>

- (void) reportErrorWithReason:(NSString*)reason; 
- (void) reportWarningWithReason:(NSString*)reason; 
- (void) reportMessageWithTitle:(NSString*)title message:(NSString*)message;

@end