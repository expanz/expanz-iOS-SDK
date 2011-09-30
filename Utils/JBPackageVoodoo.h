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

/**
 * Unlock private filter API. 
 */
@interface CAFilter : NSObject 

+ (CAFilter*) filterWithName: (NSString*) name;

@end


/* *************************************************** Dao ********************************************************** */




/* ************************************************** Model ********************************************************* */
#import "ex_security_SessionRequest.h"
@compatibility_alias SessionRequest ex_security_SessionRequest;

#import "ex_security_SessionContextHolder.h"
@compatibility_alias SessionContextHolder ex_security_SessionContextHolder;


/* ************************************************* Services ******************************************************* */
#import "JBServiceLocator.h"


/* *********************************************** User Interface *************************************************** */
#import "expanz_ui_LoginViewController.h"
@compatibility_alias LoginViewController expanz_ui_LoginViewController;

/* *************************************************** Utils ******************************************************** */


/* ************************************************* Security ******************************************************* */
#import "ex_security_LoginClient.h"

#import "ex_security_XmlPostLoginClient.h"
@compatibility_alias XmlPostLoginClient ex_security_XmlPostLoginClient;


/* ******************************************* Dependency Injection ************************************************* */
#import "JBDependencyBinder.h"

