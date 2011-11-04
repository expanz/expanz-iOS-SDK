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
        it(@"Should hold a collection of cells", ^{
            TextCell* cell = [[TextCell alloc] initWithCellId:@"firstName" text:@"Jasper"];
            [row addCell:cell];
            [cell release];

            assertThatInt([[row cells] count], equalToInt(1));
        });

        it(@"Should allow returning a sorted list of all cells.", ^{
            TextCell* cell = [[TextCell alloc] initWithCellId:@"firstName" text:@"Jasper"];
            [row addCell:cell];
            [cell release];

            TextCell* another = [[TextCell alloc] initWithCellId:@"address" text:@"Metro Manila"];
            [row addCell:another];
            [another release];

            NSArray* cells = [row cells];
            assertThatInt([cells count], equalToInt(2));
            
            //Cells are sorted. 
            assertThat([cells objectAtIndex:0], equalTo(another));
            assertThat([cells objectAtIndex:1], equalTo(cell));

        });

    });


    SPEC_END