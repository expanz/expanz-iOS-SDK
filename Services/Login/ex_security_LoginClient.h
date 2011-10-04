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
#import "JBPackageVoodoo.h"


/* ================================================================================================================== */
@protocol ex_security_LoginClientDelegate <NSObject>

- (void) requestDidFinishWithSessionContext:(SessionContextHolder*)sessionContext; 
- (void) requestDidFailWithError:(NSError*)error; 

@end

/* ================================================================================================================== */
@protocol ex_security_LoginClient <NSObject>


+ (id<ex_security_LoginClient>) loginClient;

/** 
 * Presents credentials to the expanz server and returns a SessionContextHolder, which contains a session token.  
 */
- (void) createSessionWith:(SessionRequest*)sessionRequest delegate:(id<ex_security_LoginClientDelegate>)delegate;
@end



