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
 * TODO: Replace this with Library call. 
 */
@interface CAFilter : NSObject 

+ (CAFilter*) filterWithName: (NSString*) name;

@end


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Application Context ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
@class expanz_iOS_SDKModule;
#import "expanz_iOS_SDKModule.h"
@compatibility_alias SDKModule expanz_iOS_SDKModule;


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Services ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#import "test_expanz_com_ServiceUrls.h"

/* ================================================================================================================== */
@class expanz_service_XmlPostWebService;
#import "expanz_service_XmlPostWebService.h"
@compatibility_alias XmlPostWebService expanz_service_XmlPostWebService;


/* ================================================================================================================== */
#pragma mark Login

#import "expanz_service_SessionRequest.h"
@compatibility_alias SessionRequest expanz_service_SessionRequest;

#import "expanz_service_SessionContextHolder.h"
@compatibility_alias SessionContextHolder expanz_service_SessionContextHolder;

#import "expanz_service_LoginClient.h"
#import "expanz_service_XmlPostLoginClient.h"
@compatibility_alias XmlPostLoginClient expanz_service_XmlPostLoginClient;


/* ================================================================================================================== */
#pragma mark GetSessionData

@class expanz_service_SessionDataRequest;
#import "expanz_service_SessionDataRequest.h"
@compatibility_alias SessionDataRequest expanz_service_SessionDataRequest;


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ User Interface ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#import "expanz_ui_ActivityViewController.h"
@compatibility_alias ActivityViewController expanz_ui_ActivityViewController;

#import "expanz_ui_LoginViewController.h"
@compatibility_alias LoginViewController expanz_ui_LoginViewController;


/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Utils ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#import "jb_xml_Serializable.h"

/* ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Exceptions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ */
#import "expanz_iOS_SDKExceptions.h"
