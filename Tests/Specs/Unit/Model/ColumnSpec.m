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

#import "expanz_model_Column.h"

SPEC_BEGIN(ColumnSpec)

    __block Column* column;

    beforeEach(^{
        column = [[Column alloc]
            initWithColumnId:@"1" field:@"firstName" label:@"First Name" dataType:ExpanzDataTypeString width:70];
    });

    describe(@"Object creation.", ^{

        it(@"should allow creation with firstName, label, dataType & width attributes", ^{
            [column shouldNotBeNil];
            [[[column fieldId] should] equal:@"firstName"];
            [[[column label] should] equal:@"First Name"];
            [[theValue([column dataType]) should] equal:theValue(ExpanzDataTypeString)];
            [[theValue([column width]) should] equal:[NSNumber numberWithInt:70]];
        });
    });


SPEC_END