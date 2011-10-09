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

@interface expanz_model_Menu : NSObject

@property (nonatomic, readonly, getter = hasWorkFlowTrays) BOOL hasWorkFlowTrays; 
@property (nonatomic, readonly, getter = canChangeCompanyRole) BOOL canChangeCompanyRole;

@end

/* ================================================================================================================== */
@compatibility_alias Menu expanz_model_Menu;
