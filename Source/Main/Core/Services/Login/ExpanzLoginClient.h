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

@class expanz_service_SessionRequest;
@class expanz_model_SessionContext;
@protocol ExpanzLoginClientDelegate;


@protocol ExpanzLoginClientDelegate<ExpanzAbstractServiceClientDelegate>

@optional

- (void) requestDidFinishWithSessionContext:(expanz_model_SessionContext*)sessionContext;

@end
/* ================================================================================================================== */

@protocol ExpanzLoginClient<NSObject>

/** 
 * Presents credentials to the expanz server and returns a SessionContext, which contains a session token.  
 */
- (void) createSessionWith:(expanz_service_SessionRequest*)sessionRequest 
                  delegate:(id<ExpanzLoginClientDelegate>)delegate;

@end




