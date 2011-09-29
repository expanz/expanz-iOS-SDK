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

@interface ex_security_SessionRequest : NSObject

#define kAuthenticationMode @"Primary" 
#define kClientVersion @"iOS 1.0"
#define kSchemaVersion @"2.0"


@property (nonatomic, retain) NSString* userName; 
@property (nonatomic, retain) NSString* password;
@property (nonatomic, retain) NSString* appSite;


-(NSString*) toXml; 

@end
