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
@class expanz_model_ActivityInstance;

@protocol expanz_service_ActivityClientDelegate<NSObject>

- (void) requestDidFinishWithActivityInstance:(expanz_model_ActivityInstance*)activityInstance;
- (void) requestDidFailWithError:(NSError*)error;

@end