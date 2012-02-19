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
#import "expanz_service_LoginClientDelegate.h"

@class expanz_service_SessionRequest;
@class expanz_model_SessionContext;

@protocol expanz_service_LoginClient <NSObject>

/** 
 * Presents credentials to the expanz server and returns a SessionContext, which contains a session token.  
 */
- (void) createSessionWith:(expanz_service_SessionRequest*)sessionRequest 
                  delegate:(id<expanz_service_LoginClientDelegate>)delegate;

@end




