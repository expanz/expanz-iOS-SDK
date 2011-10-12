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
#import "expanz_service_LoginClient.h"
#import "expanz_service_SessionRequest.h"
#import "expanz_model_SessionContext.h"


/* ================================================================================================================== */
@protocol expanz_service_LoginClientDelegate <NSObject>

- (void) requestDidFinishWithSessionContext:(SessionContext*)sessionContext; 
- (void) requestDidFailWithError:(NSError*)error; 

@end

/* ================================================================================================================== */


@protocol expanz_service_LoginClient <NSObject>

/** 
 * Presents credentials to the expanz server and returns a SessionContext, which contains a session token.  
 */
- (void) createSessionWith:(SessionRequest*)sessionRequest delegate:(id<expanz_service_LoginClientDelegate>)delegate;

@end




