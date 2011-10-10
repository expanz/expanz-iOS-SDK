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

#import "expanz_model_Menu.h"

@implementation expanz_model_Menu

@synthesize hasWorkflowTrays = _hasWorkflowTrays;
@synthesize canChangeCompanyRole = _canChangeCompanyRole;

/* ================================================== Constructors ================================================== */

- (id) init {
    self = [super init];    
    if (!self) {
        [NSException raise:@"Initialization failed." format:@"Call to superclass initializer failed."];
    }    
    return self;
}

- (id) initWithHasWorkFlowTrays:(BOOL)hasWorkflowTrays canChangeCompanyRole:(BOOL)canChangeCompanyRole {
    self = [self init]; 
    _hasWorkflowTrays = hasWorkflowTrays; 
    _canChangeCompanyRole = canChangeCompanyRole;
    _processAreas = [[NSMutableSet alloc] init];
    _userRoles = [[NSMutableSet alloc] init];
    return self; 
}

/* ================================================ Interface Methods =============================================== */

- (NSSet*) processAreas {
    return [[_processAreas copy] autorelease];
}

- (void) addProcessArea:(ProcessArea*)processArea {
    [_processAreas addObject:processArea];    
}

- (NSSet*) userRoles {
    return [[_userRoles copy] autorelease];
}

- (void) addUserRole:(UserRole*)userRole {
    [_userRoles addObject:userRole];    
}

/* ================================================== Utility Methods =============================================== */

- (NSString*) description {
    return [NSString stringWithFormat:@"Menu: hasWorkFlowTrays=%@, canChangeCompanyRole=%@, processAreas=%@, \
            userRoles=%@", _hasWorkflowTrays == YES ? @"YES" : @"NO", 
            _canChangeCompanyRole == YES ? @"YES" : @"NO", _processAreas, _userRoles];
}

- (void) dealloc {
    [_processAreas release]; 
    [_userRoles release];
    [super dealloc];
}

@end
