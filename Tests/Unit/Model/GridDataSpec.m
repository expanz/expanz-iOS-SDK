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
#import "expanz_model_Column.h"
#import "expanz_model_Row.h"

SPEC_BEGIN(GridDataSpec)

        __block GridData* data;

        beforeEach(^{
            data = [[GridData alloc]
                    initWithDataId:@"customersList" source:@"Customer.ListMe" query:nil contextObject:nil];
        });

        describe(@"Object creation", ^{

            it(@"Should allow instantiation with id and source attributes.", ^{
                [data shouldNotBeNil];
                [theValue(data.dataId)  shouldNotBeNil];
                [theValue(data.source) shouldNotBeNil];
            });
        });

        describe(@"Association with columns", ^{

            it(@"should return the list of fields IDs that it contains", ^{

                Column* column = [[Column alloc]
                        initWithColumnId:@"1" field:@"firstName" label:@"First Name" dataType:ExpanzDataTypeString
                        width:70];
                [data addColumn:column];
                Column* another = [[Column alloc]
                        initWithColumnId:@"1" field:@"lastName" label:@"Lirst Name" dataType:ExpanzDataTypeString
                        width:70];
                [data addColumn:another];

                NSArray* fieldNames = [data fieldIdentifiers];
                LogDebug(@"Field names: %@", fieldNames);
                [fieldNames shouldNotBeNil];
                [[[fieldNames objectAtIndex:0] should] equal:@"firstName"];
                [[[fieldNames objectAtIndex:1] should] equal:@"lastName"];
            });

            it(@"Should hold a reference to it's columns", ^{
                Column* column = [[Column alloc] initWithColumnId:@"1" field:@"firstName" label:@"Customer First Name"
                        dataType:ExpanzDataTypeString width:70];
                [data addColumn:column];

                [[theValue([[data columns] count]) should] equal:[NSNumber numberWithInt:1]];
            });

            it(@"Should allow retrieving a column by id", ^{
                Column* column = [[Column alloc] initWithColumnId:@"1" field:@"firstName" label:@"Customer First Name"
                        dataType:ExpanzDataTypeString width:70];
                [data addColumn:column];

                Column* retrieved = [data columnWithId:@"1"];
                [[retrieved should] equal:column];

                //Not stored.
                [[data columnWithId:@"99999"] shouldBeNil];
            });

            it(@"Should be able to return all columns by copy.", ^{
                Column* column = [[Column alloc] initWithColumnId:@"1" field:@"firstName" label:@"Customer First Name"
                        dataType:ExpanzDataTypeString width:70];
                [data addColumn:column];

                Column* another = [[Column alloc] initWithColumnId:@"2" field:@"lastName" label:@"Customer Last Name"
                        dataType:ExpanzDataTypeString width:70];
                [data addColumn:another];

                NSArray* theColumns = [data columns];
                [[theValue([theColumns count]) should] equal:[NSNumber numberWithInt:2]];
            });


        });

        describe(@"Association with rows", ^{

            it(@"Should hold a reference to it's rows", ^{
                Row* row = [[Row alloc] initWithRowId:@"1" type:@"ESA.Sales.Customer"];
                [data addRow:row];

                [[theValue([[data rows] count]) should] equal:[NSNumber numberWithInt:1]];
            });

            it(@"Should allow retrieving a row by id", ^{
                Row* row = [[Row alloc] initWithRowId:@"1" type:@"ESA.Sales.Customer"];
                [data addRow:row];

                Row* retrieved = [data rowWithId:@"1"];
                [[retrieved should] equal:row];

                //Not stored
                [[data rowWithId:@"99999"] shouldBeNil];
            });

            it(@"Should be able to return all rows by copy, as a sorted list.", ^{
                Row* row = [[Row alloc] initWithRowId:@"2" type:@"ESA.Sales.Customer"];
                [data addRow:row];

                Row* another = [[Row alloc] initWithRowId:@"1" type:@"ESA.Sales.Customer"];
                [data addRow:another];


                NSArray* rows = [data rows];
                [[theValue([rows count]) should] equal:[NSNumber numberWithInt:2]];

                //They've been sorted.
                [[[rows objectAtIndex:0] should] equal:another];
                [[[rows objectAtIndex:1] should] equal:row];
            });

        });

        SPEC_END