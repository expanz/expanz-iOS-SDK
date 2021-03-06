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
@class expanz_model_ActivityInstance;

@interface IntegrationUtils : NSObject

+ (void) useDefaultBackendForIntegrationTests;
+ (void) loginWithDefaultUserIfRequired; 
+ (expanz_model_ActivityInstance*) aValidActivity;

@end
