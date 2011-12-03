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

@class expanz_model_SessionContext;

@protocol expanz_service_LoginClientDelegate<NSObject>

- (void) requestDidFinishWithSessionContext:(expanz_model_SessionContext*)sessionContext;
- (void) requestDidFailWithError:(NSError*)error;

@end