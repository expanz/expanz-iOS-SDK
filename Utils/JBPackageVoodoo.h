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


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Services ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#import "JBServiceLocator.h"


/* ================================================================================================================== */
#pragma mark Login

#import "expanz_security_SessionRequest.h"
@compatibility_alias SessionRequest expanz_security_SessionRequest;

#import "expanz_security_SessionContextHolder.h"
@compatibility_alias SessionContextHolder expanz_security_SessionContextHolder;

#import "expanz_security_LoginClient.h"
#import "expanz_security_XmlPostLoginClient.h"
@compatibility_alias XmlPostLoginClient expanz_security_XmlPostLoginClient;


/* ================================================================================================================== */
#pragma mark GetSessionData
#import "expanz_session_SessionDataRequest.h"
@class expanz_session_SessionDataRequest;
@compatibility_alias SessionDataRequest expanz_session_SessionDataRequest;


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ User Interface ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#import "expanz_ui_ActivityViewController.h"
@compatibility_alias ActivityViewController expanz_ui_ActivityViewController;

#import "expanz_ui_LoginViewController.h"
@compatibility_alias LoginViewController expanz_ui_LoginViewController;


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Utils ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#import "jb_xml_Serializable.h"
#import "JBDependencyBinder.h"

