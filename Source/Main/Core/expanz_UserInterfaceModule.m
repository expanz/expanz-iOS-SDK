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

#import "expanz_ui_AlertBoxSystemEventReporter.h"
#import "expanz_UserInterfaceModule.h"

@implementation expanz_UserInterfaceModule

- (void) configure {
    [super configure];
    [self bindClass:[AlertBoxSystemEventReporter class] toProtocol:@protocol(expanz_ui_SystemEventReporter)];
}

@end 
