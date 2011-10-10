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
#import "expanz_service_SessionDataRequest.h"
#import "expanz_model_Menu.h"

/* ================================================================================================================== */
@protocol expanz_service_SessionDataClientDelegate <NSObject>

- (void) requestDidFinishWithMenu:(Menu*)menu; 
- (void) requestDidFailWithError:(NSError*)error; 

@end

/* ================================================================================================================== */

@protocol expanz_service_SessionDataClient <NSObject>


/** 
 * Presents credentials to the expanz server and returns a SessionContextHolder, which contains a session token.  
 */
- (void) retrieveSessionDataWith:(SessionDataRequest*)sessionDataRequest 
                        delegate:(id<expanz_service_SessionDataClientDelegate>)delegate;

@end
