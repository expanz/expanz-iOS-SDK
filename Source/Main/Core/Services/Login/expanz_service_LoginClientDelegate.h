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

@class expanz_model_SessionContext;

@protocol expanz_service_LoginClientDelegate<expanz_service_AbstractServiceClientDelegate>

- (void) requestDidFinishWithSessionContext:(expanz_model_SessionContext*)sessionContext;

@end