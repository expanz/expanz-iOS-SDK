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
#import "expanz_service_CreateActivityRequest.h"
#import "expanz_service_DeltaRequest.h"
#import "expanz_model_ActivityInstance.h"


/* ================================================================================================================== */
@protocol expanz_service_ActivityClientDelegate <NSObject>

- (void) requestDidFinishWithActivityInstance:(ActivityInstance*)activityInstance; 
- (void) requestDidFailWithError:(NSError*)error; 

@end

/* ================================================================================================================== */

@protocol expanz_service_ActivityClient <NSObject>

- (void) createActivityWith:(CreateActivityRequest*)activityRequest 
                delegate:(id<expanz_service_ActivityClientDelegate>)delegate;

- (void) createDeltaWith:(DeltaRequest*)deltaRequest 
                delegate:(id<expanz_service_ActivityClientDelegate>)delegate; 



@end
