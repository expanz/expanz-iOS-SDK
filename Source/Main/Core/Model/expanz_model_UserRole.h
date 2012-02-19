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

@interface expanz_model_UserRole : NSObject

@property(nonatomic, strong, readonly) NSString* roleId;
@property(nonatomic, strong, readonly) NSString* roleDescription;

- (id) initWithRoleId:(NSString*)roleId andDescription:(NSString*)description;

@end

/* ================================================================================================================== */
@compatibility_alias UserRole expanz_model_UserRole;


