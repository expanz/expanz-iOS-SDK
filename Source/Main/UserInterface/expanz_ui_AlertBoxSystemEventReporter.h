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


@interface expanz_ui_AlertBoxSystemEventReporter : NSObject<expanz_ui_SystemEventReporter>

@property (nonatomic, assign) id<UIAlertViewDelegate> delegate;

@end

/* ================================================================================================================== */
@compatibility_alias AlertBoxSystemEventReporter expanz_ui_AlertBoxSystemEventReporter;