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
            assertThatBool([renderer isKindOfClass:[GridDataRenderer class]], equalToBool(YES));

        });

        it(@"should return a TreeDataRenderer for tree data", ^{

            TreeData* treeData = [[TreeData alloc] initWithDataId:@"documents"];
            UITableView* tableView = [[UITableView alloc] init];

            AbstractDataRenderer* renderer = [treeData withDataRendererFor:tableView activityName:@"Documents"];
            assertThatBool([renderer isKindOfClass:[TreeDataRenderer class]], equalToBool(YES));

        });

        it(@"should return nil if invoked directly.", ^{
            AbstractData* abstractData = [[AbstractData alloc] initWithDataId:@"abstract"];
            UITableView* tableView = [[UITableView alloc] init];

            assertThat([abstractData withDataRendererFor:tableView activityName:@"abstract"], nilValue());
        });

    });

    SPEC_END