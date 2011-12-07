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
#import "expanz_model_ProcessArea.h"
#import "expanz_model_UserRole.h"


@implementation expanz_model_Menu

@synthesize hasWorkflowTrays = _hasWorkflowTrays;
@synthesize canChangeCompanyRole = _canChangeCompanyRole;

/* ================================================== Initializers ================================================== */
- (id)initWithHasWorkFlowTrays:(BOOL)hasWorkflowTrays canChangeCompanyRole:(BOOL)canChangeCompanyRole {
    self = [super init];
    if (self) {
        _hasWorkflowTrays = hasWorkflowTrays;
        _canChangeCompanyRole = canChangeCompanyRole;
        _processAreas = [[NSMutableSet alloc] init];
        _userRoles = [[NSMutableSet alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*)processAreas {
    NSSortDescriptor* sorter = [[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease];
    return [_processAreas sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void)addProcessArea:(ProcessArea*)processArea {
    [_processAreas addObject:processArea];
}

- (expanz_model_ProcessArea*)processAreaWithId:(NSString*)processAreaId {
    for (ProcessArea* processArea in _processAreas) {
        if ([processArea.processId isEqualToString:processAreaId]) {
            return processArea;
        }
    }
    return nil;
}

- (NSArray*)userRoles {
    NSSortDescriptor* sorter = [[[NSSortDescriptor alloc] initWithKey:@"description" ascending:YES] autorelease];
    return [_userRoles sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void)addUserRole:(UserRole*)userRole {
    [_userRoles addObject:userRole];
}


- (NSArray*)allActivities {
    if (_allActivities == nil) {
        _allActivities = [[NSMutableArray alloc] init];
        for (ProcessArea* processArea in [self processAreas]) {
            [_allActivities addObjectsFromArray:[processArea activities]];
        }
    }
    NSSortDescriptor* sorter = [[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease];
    return [_allActivities sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

/* ================================================== Utility Methods =============================================== */
- (NSString*)description {
    return [NSString stringWithFormat:@"Menu: hasWorkFlowTrays=%@, canChangeCompanyRole=%@, processAreas=%@, \
            userRoles=%@", _hasWorkflowTrays == YES ? @"YES" : @"NO", _canChangeCompanyRole == YES ? @"YES" : @"NO",
                                      _processAreas, _userRoles];
}

- (void)dealloc {
    [_allActivities release];
    [_processAreas release];
    [_userRoles release];
    [super dealloc];
}

@end
