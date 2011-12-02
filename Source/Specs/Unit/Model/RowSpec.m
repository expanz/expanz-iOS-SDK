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

        beforeEach(^{
            Column* column1 = [[Column alloc]
                initWithColumnId:@"firstName" field:@"firstName" label:nil dataType:ExpanzDataTypeString width:70];
            Column* column2 = [[Column alloc]
                initWithColumnId:@"address" field:@"address" label:nil dataType:ExpanzDataTypeString width:70];
            GridData* dataSet = [[GridData alloc] initWithDataId:@"foobar" source:@"zzz"];
            [dataSet addColumn:column1];
            [dataSet addColumn:column2];
            [column1 release];
            [column2 release];
            [row setDataSet:dataSet];
        });

        it(@"Should hold a collection of cells", ^{
            [row addCellDefinitionWithId:@"firstName" data:@"Jasper"];
            assertThatInt([[row cells] count], equalToInt(1));
        });
        
        it(@"should allow returning a cell by cellId", ^{
            [row addCellDefinitionWithId:@"firstName" data:@"Jasper"];
            [row addCellDefinitionWithId:@"address" data:@"Metro Manila"];

            BaseCell* retrieved = [row cellWithId:@"firstName"];
            assertThat(retrieved.cellId, equalTo(@"firstName"));
        });

        it(@"Should allow returning a sorted list of all cells.", ^{
            [row addCellDefinitionWithId:@"firstName" data:@"Jasper"];
            [row addCellDefinitionWithId:@"address" data:@"Metro Manila"];

            NSArray* cells = [row cells];
            assertThatInt([cells count], equalToInt(2));

            //Cells are sorted. 
            assertThat([[cells objectAtIndex:0] cellId], equalTo(@"address"));
            assertThat([[cells objectAtIndex:1] cellId], equalTo(@"firstName"));
        });

    });


    SPEC_END