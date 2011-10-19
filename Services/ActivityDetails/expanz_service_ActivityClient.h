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
@class expanz_model_ActivityInstance;
@class expanz_service_CreateActivityRequest;
@class expanz_service_DeltaRequest;


/* ================================================================================================================== */
@protocol expanz_service_ActivityClientDelegate <NSObject>

- (void) requestDidFinishWithActivityInstance:(expanz_model_ActivityInstance*)activityInstance; 
- (void) requestDidFailWithError:(NSError*)error; 

@end

/* ================================================================================================================== */

@protocol expanz_service_ActivityClient <NSObject>

- (void) createActivityWith:(expanz_service_CreateActivityRequest*)activityRequest 
                delegate:(id<expanz_service_ActivityClientDelegate>)delegate;

- (void) createDeltaWith:(expanz_service_DeltaRequest*)deltaRequest 
                delegate:(id<expanz_service_ActivityClientDelegate>)delegate; 



@end
