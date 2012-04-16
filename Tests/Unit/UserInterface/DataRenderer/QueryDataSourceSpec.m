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


#import "expanz_ui_QueryDataSource.h"

SPEC_BEGIN(QueryDataSourceSpec)

        it(@"should should allow the user to select the query to use from Interface Builder", ^{

            QueryDataSource* dataSource = [[QueryDataSource alloc] init];
            [dataSource setValue:[NSNumber numberWithBool:YES] forKey:@"CustomersListMobile"];

            NSString* query = [dataSource query];
            [[query should] equal:@"CustomersListMobile"];
        });

        it(@"should throw an exception if more than one query is set.", ^{

            [[theBlock(^{
                QueryDataSource* dataSource = [[QueryDataSource alloc] init];
                [dataSource setValue:[NSNumber numberWithBool:YES] forKey:@"CustomersListMobile"];
                [dataSource setValue:[NSNumber numberWithBool:YES] forKey:@"AnotherQuery"];
                NSString* query = [dataSource query];
            }) should] raiseWithReason:(NSString*) @"Expected QueryDataSource to have one query, but instead got: (\n"
                    "    AnotherQuery,\n"
                    "    CustomersListMobile\n"
                    ")"];

        });


        SPEC_END