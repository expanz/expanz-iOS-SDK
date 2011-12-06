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
#import "expanz_service_ActivityClientDelegate.h"

@class expanz_model_ActivityInstance;
@class expanz_service_CreateActivityRequest;
@class expanz_service_DeltaRequest;
@class expanz_service_MethodInvocationRequest;
@class expanz_service_FileRequest;

@protocol expanz_service_ActivityClient <NSObject>

- (void)createActivityWith:(expanz_service_CreateActivityRequest*)activityRequest
                  delegate:(id <expanz_service_ActivityClientDelegate>)delegate;

- (void)sendDeltaWith:(expanz_service_DeltaRequest*)deltaRequest
             delegate:(id <expanz_service_ActivityClientDelegate>)delegate;

- (void)sendFileRequestWith:(expanz_service_FileRequest*)fileRequest
                   delegate:(id <expanz_service_ActivityClientDelegate>)delegate;

- (void)sendMethodInvocationWith:(expanz_service_MethodInvocationRequest*)methodRequest
                        delegate:(id <expanz_service_ActivityClientDelegate>)delegate;


@end
