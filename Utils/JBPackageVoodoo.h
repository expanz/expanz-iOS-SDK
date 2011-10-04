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
#import "expanz_security_SessionRequest.h"
@compatibility_alias SessionRequest expanz_security_SessionRequest;

#import "expanz_security_SessionContextHolder.h"
@compatibility_alias SessionContextHolder expanz_security_SessionContextHolder;


/* ************************************************* Services ******************************************************* */
#import "JBServiceLocator.h"


/* *********************************************** User Interface *************************************************** */
#import "expanz_ui_ActivityViewController.h"
@compatibility_alias ActivityViewController expanz_ui_ActivityViewController;

#import "expanz_ui_LoginViewController.h"
@compatibility_alias LoginViewController expanz_ui_LoginViewController;


/* *************************************************** Utils ******************************************************** */


/* ************************************************* Security ******************************************************* */
#import "expanz_security_LoginClient.h"

#import "expanz_security_XmlPostLoginClient.h"
@compatibility_alias XmlPostLoginClient expanz_security_XmlPostLoginClient;


/* ******************************************* Dependency Injection ************************************************* */
#import "JBDependencyBinder.h"

