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


 
@interface expanz_service_SessionContextHolder: NSObject


@property (nonatomic, retain) NSString* sessionToken; 
@property (nonatomic) BOOL hasError; 
@property (nonatomic, retain) NSString* errorMessage;
@property (nonatomic) BOOL hasWarning;
@property (nonatomic, retain) NSString* warningMessage;


+ (void)setGlobalContext:(expanz_service_SessionContextHolder*)context;
+ (expanz_service_SessionContextHolder*) globalContext;


/**
 * Create an autoreleased instance from XML. 
 */
+ (id) fromXml:(NSString*)xml;


/**
 * Create an instance with XML. 
 */
- (id) initWithXml:(NSString*)xml; 

@end

/* ================================================================================================================== */
@compatibility_alias SessionContextHolder expanz_service_SessionContextHolder;
