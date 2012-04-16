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
#import "expanz_model_ActivityMenuItem.h"


SPEC_BEGIN(MenuSpec)

    describe(@"Object creation", ^{
        it(@"should allow initialization with workFlowTrays and canChangeCompanyRoles boolean flags", ^{
            Menu* menu = [[Menu alloc] initWithHasWorkFlowTrays:YES canChangeCompanyRole:NO];
            [[theValue(menu.hasWorkflowTrays) should] beYes];
            [[theValue(menu.canChangeCompanyRole) should] beNo];
            [[menu description] shouldNotBeNil];

        });
    });

    describe(@"Process Areas", ^{

        __block Menu* menu;

        beforeEach(^{
            menu = [[Menu alloc] initWithHasWorkFlowTrays:YES canChangeCompanyRole:NO];
        });

        it(@"should contain a processAreas property, that is initialized empty.", ^{
            [[menu.processAreas should] beEmpty];            
        });

        it(@"should store a process area reference via an add method.", ^{
            ProcessArea* processArea = [[ProcessArea alloc] initWithProcessId:@"1234" andTitle:@"My Process"];
            [menu addProcessArea:processArea];
            [[[menu.processAreas should] have:1] items];
        });

        it(@"should allow returning a process area by id", ^{
            ProcessArea* processArea = [[ProcessArea alloc] initWithProcessId:@"1234" andTitle:@"My Process"];
            [menu addProcessArea:processArea];

            ProcessArea* retrieved = [menu processAreaWithId:@"1234"];
            [[retrieved should] equal:processArea];

            retrieved = [menu processAreaWithId:@"id.not.stored"];
            [retrieved shouldBeNil];

        });

        it(@"should allow returning the activities for all process areas as a single sorted collection", ^{
            ProcessArea* processArea1 = [[ProcessArea alloc] initWithProcessId:@"Documents" andTitle:@"Documents"];

            ActivityMenuItem* activity1 = [[ActivityMenuItem alloc]
                initWithActivityId:@"Customers" title:@"Customers" style:[ActivityStyle defaultStyle]];
            ActivityMenuItem* activity2 = [[ActivityMenuItem alloc]
                initWithActivityId:@"Invoices" title:@"Invoices" style:[ActivityStyle defaultStyle]];

            [processArea1 addActivityDefinition:activity1];
            [processArea1 addActivityDefinition:activity2];
            [menu addProcessArea:processArea1];

            ProcessArea* processArea2 = [[ProcessArea alloc] initWithProcessId:@"Consultants" andTitle:@"Consultants"];

            ActivityMenuItem* activity3 = [[ActivityMenuItem alloc]
                initWithActivityId:@"Order Tracking" title:@"Order Tracking" style:[ActivityStyle defaultStyle]];
            ActivityMenuItem* activity4 = [[ActivityMenuItem alloc]
                initWithActivityId:@"Engagements" title:@"Engagements" style:[ActivityStyle defaultStyle]];

            [processArea2 addActivityDefinition:activity3];
            [processArea2 addActivityDefinition:activity4];
            [menu addProcessArea:processArea2];

            ProcessArea* processArea3 = [[ProcessArea alloc] initWithProcessId:@"Consultants" andTitle:@"Consultants"];
            [menu addProcessArea:processArea3];

            [[[menu allActivities] should] haveCountOf:4];
        });

    });

    describe(@"User Roles. . . ", ^{
        __block Menu* menu;

        beforeEach(^{
            menu = [[Menu alloc] initWithHasWorkFlowTrays:YES canChangeCompanyRole:NO];
        });

        it(@"should contain a userRoles property that is initialized empty.", ^{
            [[menu.userRoles should] beEmpty];
        });

        it(@"should store a user role reference, via an add method.", ^{
            UserRole* userRole = [[UserRole alloc] initWithRoleId:@"123" andDescription:@"Sales Manager"];
            [menu addUserRole:userRole];
            [[menu.userRoles should] haveCountOf:1];
        });

    });

    SPEC_END
