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

@class expanz_model_Menu;
@class expanz_service_SessionDataRequest;
@protocol ExpanzSessionDataClientDelegate;
@class expanz_model_SessionData;

@protocol ExpanzSessionDataClientDelegate<ExpanzAbstractServiceClientDelegate>

@optional

- (void) requestDidFinishWithSessionData:(expanz_model_SessionData*)sessionData;

@end
/* ================================================================================================================== */

@protocol ExpanzSessionDataClient<NSObject>

/** 
 * Presents credentials to the expanz server and returns a SessionContext, which contains a session token.  
 */
- (void) retrieveSessionDataWith:(expanz_service_SessionDataRequest*)sessionDataRequest 
                        delegate:(id<ExpanzSessionDataClientDelegate>)delegate;

@end
