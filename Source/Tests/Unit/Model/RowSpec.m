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
#import "../../../Main/Model/expanz_model_GridData.h"
#import "expanz_model_Column.h"
#import "expanz_model_Row.h"
#import "expanz_model_TextCell.h"


SPEC_BEGIN(RowSpec)

    __block Row* row;


    beforeEach(^{
        row = [[Row alloc] initWithRowId:@"1" type:@"ESA.Sales.Customer"];
    });

    describe(@"Object creation", ^{
        it(@"should allow instantiation with rowid and type attributes", ^{
            assertThat(row, notNilValue());
            assertThat(row.rowId, equalTo(@"1"));
            assertThat(row.type, equalTo(@"ESA.Sales.Customer"));
        });
    });

    describe(@"Association with cells", ^{

        __block GridData* dataSet;

        beforeEach(^{
            Column* column1 = [[Column alloc]
                initWithColumnId:@"1" field:@"firstName" label:nil dataType:ExpanzDataTypeString width:70];
            Column* column2 = [[Column alloc]
                initWithColumnId:@"2" field:@"address" label:nil dataType:ExpanzDataTypeString width:70];
            dataSet = [[GridData alloc] initWithDataId:@"foobar" source:@"zzz"];
            [dataSet addColumn:column1];
            [dataSet addColumn:column2];
            [dataSet addRow:row];
        });

        it(@"Should hold a collection of cells", ^{
            [row addCellDefinitionWithId:@"1" data:@"Jasper"];
            assertThatInt([[row cells] count], equalToInt(1));
        });
        
        it(@"should allow returning a cell by cellId", ^{
            [row addCellDefinitionWithId:@"1" data:@"Jasper"];
            [row addCellDefinitionWithId:@"2" data:@"Metro Manila"];

            AbstractCell* retrieved = [row cellWithId:@"1"];
            assertThat(retrieved.cellId, equalTo(@"1"));
        });

        it(@"should allow returning a cell by field name", ^{
            [row addCellDefinitionWithId:@"1" data:@"Jasper"];
            [row addCellDefinitionWithId:@"2" data:@"Metro Manila"];

            AbstractCell* retrieved = [row cellForFieldId:@"firstName"];
            assertThat(retrieved.cellId, equalTo(@"1"));

        });

        it(@"Should allow returning a sorted list of all cells.", ^{
            [row addCellDefinitionWithId:@"2" data:@"Jasper"];
            [row addCellDefinitionWithId:@"1" data:@"Metro Manila"];

            NSArray* cells = [row cells];
            assertThatInt([cells count], equalToInt(2));

            //Cells are sorted. 
            assertThat([[cells objectAtIndex:0] cellId], equalTo(@"1"));
            assertThat([[cells objectAtIndex:1] cellId], equalTo(@"2"));
        });

    });


    SPEC_END