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
#import "expanz_ui_SystemEventReporter.h"


@interface StubSystemEventReporter : NSObject<expanz_ui_SystemEventReporter>

@property(nonatomic, strong) NSString* message;

@end
