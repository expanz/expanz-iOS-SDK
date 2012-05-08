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
#import "expanz_model_TextGridDataCell.h"


SPEC_BEGIN(RowSpec)

        __block Row* row;


        beforeEach(^{
            row = [[Row alloc] initWithRowId:@"1" type:@"ESA.Sales.Customer"];
        });

        describe(@"Object creation", ^{
            it(@"should allow instantiation with rowid and type attributes", ^{
                [row shouldNotBeNil];
                [[[row rowId] should] equal:@"1"];
                [[[row type] should] equal:@"ESA.Sales.Customer"];
            });
        });

        describe(@"Association with cells", ^{

            __block GridData* dataSet;

            beforeEach(^{
                Column* column1 = [[Column alloc]
                        initWithColumnId:@"1" field:@"firstName" label:nil dataType:ExpanzDataTypeString width:70];
                Column* column2 = [[Column alloc]
                        initWithColumnId:@"2" field:@"address" label:nil dataType:ExpanzDataTypeString width:70];
                dataSet = [[GridData alloc] initWithDataId:@"foobar" source:@"zzz" query:nil contextObject:nil];
                [dataSet addColumn:column1];
                [dataSet addColumn:column2];
                [dataSet addRow:row];
            });

            it(@"Should hold a collection of cells", ^{
                [row addCellDefinitionWithId:@"1" data:@"Jasper"];
                [[[row cells] should] haveCountOf:1];
            });

            it(@"should allow returning a cell by cellId", ^{
                [row addCellDefinitionWithId:@"1" data:@"Jasper"];
                [row addCellDefinitionWithId:@"2" data:@"Metro Manila"];

                AbstractGridDataCell* retrieved = [row cellWithId:@"1"];
                [[[retrieved cellId] should] equal:@"1"];
            });

            it(@"should allow returning a cell by field name", ^{
                [row addCellDefinitionWithId:@"1" data:@"Jasper"];
                [row addCellDefinitionWithId:@"2" data:@"Metro Manila"];

                AbstractGridDataCell* retrieved = [row cellForFieldId:@"firstName"];
                [[[retrieved cellId] should] equal:@"1"];
            });

            it(@"Should allow returning a sorted list of all cells.", ^{
                [row addCellDefinitionWithId:@"2" data:@"Jasper"];
                [row addCellDefinitionWithId:@"1" data:@"Metro Manila"];

                NSArray* cells = [row cells];
                [[cells should] haveCountOf:2];

                //Cells are sorted.
                [[[[cells objectAtIndex:0] cellId] should] equal:@"1"];
                [[[[cells objectAtIndex:1] cellId] should] equal:@"2"];
            });

        });


        SPEC_END