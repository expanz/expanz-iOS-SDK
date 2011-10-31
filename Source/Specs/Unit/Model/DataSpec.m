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
#import "expanz_model_Data.h"
#import "expanz_model_Column.h"
#import "expanz_model_Row.h"

SPEC_BEGIN(DataSpec)

    __block Data* data;

    beforeEach(^{
        data = [[[Data alloc] initWithDataId:@"customersList" source:@"Customer.ListMe"] autorelease];
    });

    describe(@"Object creation", ^{

        it(@"Should allow instantiation with id and source attributes.", ^{
            Data* data = [[Data alloc] initWithDataId:@"customersList" source:@"Customer.ListMe"];
            assertThat(data, notNilValue());
            assertThat(data.dataId, notNilValue());
            assertThat(data.source, notNilValue());
            [data release];
        });
    });

    describe(@"Association with columns", ^{

        it(@"Should hold a reference to it's columns", ^{
            Column* column = [[Column alloc]
                initWithColumnId:@"1" field:@"firstName" label:@"Customer First Name" dataType:@"string" width:70];
            [data addColumn:column];

            assertThatInt([[data columns] count], equalToInt(1));
        });

        it(@"Should allow retrieving a column by id", ^{
            Column* column = [[Column alloc]
                initWithColumnId:@"1" field:@"firstName" label:@"Customer First Name" dataType:@"string" width:70];
            [data addColumn:column];

            Column* retrieved = [data columnWithId:@"1"];
            assertThat(retrieved, equalTo(column));
            
            //Not stored.
            Column* shouldBeNil = [data columnWithId:@"99999"];
            assertThat(shouldBeNil, nilValue());
            
        });

        it(@"Should be able to return all columns by copy.", ^{
            Column* column = [[Column alloc]
                initWithColumnId:@"1" field:@"firstName" label:@"Customer First Name" dataType:@"string" width:70];
            [data addColumn:column];

            Column* another = [[Column alloc]
                initWithColumnId:@"2" field:@"lastName" label:@"Customer Last Name" dataType:@"string" width:70];
            [data addColumn:another];

            NSArray* theColumns = [data columns];
            assertThatInt([theColumns count], equalToInt(2));            
        });


    });

    describe(@"Association with rows", ^{
        
        it(@"Should hold a reference to it's rows", ^{
            Row* row = [[Row alloc] initWithRowId:@"1" type:@"ESA.Sales.Customer"];
            [data addRow:row];

            assertThatInt([[data rows] count], equalToInt(1));
        });
        
        it(@"Should allow retrieving a row by id", ^{
            Row* row = [[Row alloc] initWithRowId:@"1" type:@"ESA.Sales.Customer"];
            [data addRow:row];
            
            Row* retrieved = [data rowWithId:@"1"];
            assertThat(retrieved, equalTo(row));
            
            //Not stored
            Row* shouldBeNil = [data rowWithId:@"99999"];
            assertThat(shouldBeNil, nilValue());
        });
        
        it(@"Should be able to return all rows by copy, as a sorted list.", ^{
            Row* row = [[Row alloc] initWithRowId:@"2" type:@"ESA.Sales.Customer"];
            [data addRow:row];
            Row* another = [[Row alloc] initWithRowId:@"1" type:@"ESA.Sales.Customer"];
            [data addRow:another];
            
            NSArray* rows = [data rows];
            assertThatInt([rows count], equalToInt(2));
            
            //They've been sorted. 
            assertThat([rows objectAtIndex:0], equalTo(another));
            assertThat([rows objectAtIndex:1], equalTo(row));
        });

    });

    SPEC_END