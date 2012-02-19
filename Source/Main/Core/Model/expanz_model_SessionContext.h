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


@interface expanz_model_SessionContext : NSObject


@property(nonatomic, retain) NSString* sessionToken;
@property(nonatomic) BOOL hasError;
@property(nonatomic) BOOL hasWarning;
@property(nonatomic, retain) NSString* message;


+ (void) setGlobalContext:(expanz_model_SessionContext*)context;

+ (expanz_model_SessionContext*) globalContext;

- (id) initWithSessionToken:(NSString*)sessionToken hasError:(BOOL)hasError hasWarning:(BOOL)hasWarning
                    message:(NSString*)message;


@end

/* ================================================================================================================== */
@compatibility_alias SessionContext expanz_model_SessionContext;
