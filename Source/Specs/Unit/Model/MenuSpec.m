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
#import "expanz_model_ProcessArea.h"
#import "expanz_model_UserRole.h"
#import "expanz_model_ActivityDefinition.h"


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
            ProcessArea
                * processArea = [[[ProcessArea alloc] initWithProcessId:@"1234" andTitle:@"My Process"] autorelease];
            [menu addProcessArea:processArea];
            assertThat(menu.processAreas, hasCountOf(1));
        });

        it(@"should allow returning a process area by id", ^{
            ProcessArea
                * processArea = [[[ProcessArea alloc] initWithProcessId:@"1234" andTitle:@"My Process"] autorelease];
            [menu addProcessArea:processArea];

            ProcessArea* retrieved = [menu processAreaWithId:@"1234"];
            assertThat(retrieved, equalTo(processArea));

            retrieved = [menu processAreaWithId:@"id.not.stored"];
            assertThat(retrieved, nilValue());

        });

        it(@"should allow returning the activities for all process areas as a single sorted collection", ^{
            ProcessArea* processArea1 =
                [[[ProcessArea alloc] initWithProcessId:@"Documents" andTitle:@"Documents"] autorelease];

            ActivityDefinition* activity1 = [[ActivityDefinition alloc]
                initWithName:@"Customers" title:@"Customers" style:[ActivityStyle defaultStyle]];
            ActivityDefinition* activity2 = [[ActivityDefinition alloc]
                initWithName:@"Invoices" title:@"Invoices" style:[ActivityStyle defaultStyle]];

            [processArea1 addActivityDefinition:activity1];
            [processArea1 addActivityDefinition:activity2];
            [menu addProcessArea:processArea1];

            ProcessArea* processArea2 =
                [[[ProcessArea alloc] initWithProcessId:@"Consultants" andTitle:@"Consultants"] autorelease];

            ActivityDefinition* activity3 = [[ActivityDefinition alloc]
                initWithName:@"Order Tracking" title:@"Order Tracking" style:[ActivityStyle defaultStyle]];
            ActivityDefinition* activity4 = [[ActivityDefinition alloc]
                initWithName:@"Engagements" title:@"Engagements" style:[ActivityStyle defaultStyle]];

            [processArea2 addActivityDefinition:activity3];
            [processArea2 addActivityDefinition:activity4];
            [menu addProcessArea:processArea2];

            ProcessArea* processArea3 =
                [[[ProcessArea alloc] initWithProcessId:@"Consultants" andTitle:@"Consultants"] autorelease];
            [menu addProcessArea:processArea3];

            assertThatInt([[menu allActivities] count], equalToInt(4));
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
