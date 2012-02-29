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

@class expanz_model_Menu;

@protocol expanz_service_SessionDataClientDelegate<expanz_service_AbstractServiceClientDelegate>

@optional

- (void) requestDidFinishWithMenu:(expanz_model_Menu*)menu;

@end