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
#import "ExpanzAbstractServiceClientDelegate.h"

@class expanz_model_ActivityInstance;
@class expanz_service_CreateActivityRequest;
@class expanz_service_DeltaRequest;
@class expanz_service_MethodInvocationRequest;
@class expanz_service_FileRequest;

@protocol ExpanzActivityClientDelegate<ExpanzAbstractServiceClientDelegate>

@optional

- (void) requestDidFinishWithActivityInstance:(expanz_model_ActivityInstance*)activityInstance;

@end

/* ================================================================================================================== */
@protocol ExpanzActivityClient<NSObject>

- (void) createActivityWith:(expanz_service_CreateActivityRequest*)activityRequest
        delegate:(id<ExpanzActivityClientDelegate>)delegate;

- (void) sendDeltaWith:(expanz_service_DeltaRequest*)deltaRequest
        delegate:(id<ExpanzActivityClientDelegate>)delegate;

- (void) sendMethodInvocationWith:(expanz_service_MethodInvocationRequest*)methodRequest
        delegate:(id<ExpanzActivityClientDelegate>)delegate;

@end



