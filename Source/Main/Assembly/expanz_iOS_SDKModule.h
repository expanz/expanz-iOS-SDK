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
#import "Objection.h"


/** 
 * Uses Objection dependency injection framework to bind protocols to concrete implementations. This allows class
 * implementations to be swapped out, with minimal code changes. 
 */
@interface expanz_ios_SdkModule : JSObjectionModule
@end

/* ================================================================================================================== */
@compatibility_alias SdkModule expanz_ios_SdkModule;
