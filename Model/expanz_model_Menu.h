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
#import "expanz_model_ProcessArea.h"
#import "expanz_model_UserRole.h"

@interface expanz_model_Menu : NSObject {
    
    NSMutableSet* _processAreas;
    NSMutableSet* _userRoles; 
}

@property (nonatomic, readonly, getter = hasWorkflowTrays) BOOL hasWorkflowTrays; 
@property (nonatomic, readonly, getter = canChangeCompanyRole) BOOL canChangeCompanyRole;
@property (nonatomic, readonly) NSArray* processAreas;
@property (nonatomic, readonly) NSArray* userRoles; 


- (id) initWithHasWorkFlowTrays:(BOOL)hasWorkflowTrays canChangeCompanyRole:(BOOL)canChangeCompanyRole; 


/**
 * Adds a ProcessArea to this menu. 
 */
- (void) addProcessArea:(ProcessArea*)processArea;


/**
 * Adds a ProcessArea to this menu. 
 */
- (void) addUserRole:(UserRole*)userRole;


@end

/* ================================================================================================================== */
@compatibility_alias Menu expanz_model_Menu;
