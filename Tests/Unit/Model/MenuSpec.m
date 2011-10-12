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

#import "SpecHelper.h"
#import "expanz_model_Menu.h"


SPEC_BEGIN(MenuSpec)

describe(@"Object creation", ^{
    it(@"should allow initialization with workFlowTrays and canChangeCompanyRoles boolean flags", ^{
        Menu* menu = [[Menu alloc] initWithHasWorkFlowTrays:YES canChangeCompanyRole:NO]; 
        assertThatBool(menu.hasWorkflowTrays, equalToBool(YES));
        assertThatBool(menu.canChangeCompanyRole, equalToBool(NO));
        assertThat([menu description], notNilValue());
        [menu release];
    });
});

describe(@"Process Areas", ^{
    
    __block Menu* menu; 
    
    beforeEach(^{
        menu = [[Menu alloc] initWithHasWorkFlowTrays:YES canChangeCompanyRole:NO]; 
    });
    
    it(@"should contain a processAreas property, that is initialized empty.", ^{
        assertThat(menu.processAreas, is(empty()));
    });
    
    it(@"should store a process area reference via an add method.", ^{
        ProcessArea* processArea = [[[ProcessArea alloc] initWithProcessId:@"1234" andTitle:@"My Process"] autorelease];
        [menu addProcessArea:processArea];
        assertThat(menu.processAreas, hasCountOf(1));
    });
            
    afterEach(^{
        [menu release];
    });
});

describe(@"User Roles. . . ", ^{
    __block Menu* menu; 
    
    beforeEach(^{
        menu = [[Menu alloc] initWithHasWorkFlowTrays:YES canChangeCompanyRole:NO]; 
    });
    
    it(@"should contain a userRoles property that is initialized empty.", ^{
        assertThat(menu.userRoles, hasCountOf(0));
    });
    
    it(@"should store a user role reference, via an add method.", ^{
        UserRole* userRole = [[[UserRole alloc] initWithRoleId:@"123" andDescription:@"Sales Manager"] autorelease];
        [menu addUserRole:userRole];
        assertThat(menu.userRoles, hasCountOf(1));
    });
    
    afterEach(^{
        [menu release];
    });
});

SPEC_END
