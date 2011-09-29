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

@protocol ex_security_LoginClient <NSObject>


/** 
 * Presents credentials to the expanz server and returns a SessionContextHolder, which contains a session token.  
 */
- (ex_security_SessionContextHolder*) createSessionWith:(SessionRequest*)sessionRequest; 




@end
