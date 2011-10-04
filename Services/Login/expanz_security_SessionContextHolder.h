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

@interface expanz_security_SessionContextHolder: NSObject


@property (nonatomic, retain) NSString* sessionToken; 
@property (nonatomic) BOOL hasError; 
@property (nonatomic, retain) NSString* errorMessage;
@property (nonatomic) BOOL hasWarning;
@property (nonatomic, retain) NSString* warningMessage;

+ (id) fromXml:(NSString*)xml;
- (id) initWithXml:(NSString*)xml; 

@end
