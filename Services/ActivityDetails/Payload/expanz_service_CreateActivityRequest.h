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

@interface expanz_service_CreateActivityRequest : NSObject

@property (nonatomic, readonly) NSString* activityName; 
@property (nonatomic, readonly) NSString* sessionToken; 


- (id) initWithActivityName:(NSString*)activityName andSessionToken:(NSString*)sessionToken;

@end

/* ================================================================================================================== */
@compatibility_alias CreateActivityRequest expanz_service_CreateActivityRequest;