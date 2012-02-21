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


#import "expanz_model_GridData.h"
#import "expanz_model_TreeData.h"
#import "expanz_ui_AbstractDataRenderer.h"
#import "expanz_ui_GridDataRenderer.h"
#import "expanz_ui_TreeDataRenderer.h"

SPEC_BEGIN(AbstractDataSpec)

    describe(@"Acting as a data renderer factory", ^{

        it(@"should return a GridDataRenderer for grid data", ^{

            GridData* gridData = [[GridData alloc] initWithDataId:@"customers"];
            UITableView* tableView = [[UITableView alloc] init];

            AbstractDataRenderer* renderer = [gridData withDataRendererFor:tableView activityName:@"Customers"];

            [[theValue([renderer isKindOfClass:[GridDataRenderer class]]) should] beYes];
        });

        it(@"should return a TreeDataRenderer for tree data", ^{

            TreeData* treeData = [[TreeData alloc] initWithDataId:@"documents"];
            UITableView* tableView = [[UITableView alloc] init];

            AbstractDataRenderer* renderer = [treeData withDataRendererFor:tableView activityName:@"Documents"];
            [[theValue([renderer isKindOfClass:[TreeDataRenderer class]]) should] beYes];

        });

        it(@"should return nil if invoked directly.", ^{
            AbstractData* abstractData = [[AbstractData alloc] initWithDataId:@"abstract"];
            UITableView* tableView = [[UITableView alloc] init];

            [[abstractData withDataRendererFor:tableView activityName:@"abstract"] shouldBeNil];
        });

    });

    SPEC_END