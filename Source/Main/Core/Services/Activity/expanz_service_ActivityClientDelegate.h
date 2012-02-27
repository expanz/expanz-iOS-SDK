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
#import "expanz_service_AbstractServiceClientDelegate.h"

@class expanz_model_ActivityInstance;

@protocol expanz_service_ActivityClientDelegate<expanz_service_AbstractServiceClientDelegate>

- (void) requestDidFinishWithActivityInstance:(expanz_model_ActivityInstance*)activityInstance;

@end