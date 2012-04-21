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

@class expanz_model_ProcessArea;
@class expanz_model_UserRole;

@interface expanz_model_Menu : NSObject {

@private
    NSMutableArray* _allActivities;
    NSMutableSet* _processAreas;
    NSMutableSet* _userRoles;
}

@property(nonatomic, readonly, getter = hasWorkflowTrays) BOOL hasWorkflowTrays;
@property(nonatomic, readonly, getter = canChangeCompanyRole) BOOL canChangeCompanyRole;
@property(nonatomic, strong, readonly) NSArray* processAreas;
@property(nonatomic, strong, readonly) NSArray* userRoles;


- (id) initWithHasWorkFlowTrays:(BOOL)hasWorkflowTrays canChangeCompanyRole:(BOOL)canChangeCompanyRole;


/**
* Adds a ProcessArea to this menu.
*/
- (void) addProcessArea:(expanz_model_ProcessArea*)processArea;

/** 
 * Returns the process area matching the supplied id, or nil. 
 */
- (expanz_model_ProcessArea*) processAreaWithId:(NSString*)processAreaId;

/**
* Adds a ProcessArea to this menu.
*/
- (void) addUserRole:(expanz_model_UserRole*)userRole;

- (NSArray*) allMenuItems;

@end

/* ================================================================================================================== */
@compatibility_alias Menu expanz_model_Menu;
