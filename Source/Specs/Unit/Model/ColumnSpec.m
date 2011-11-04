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
#import "expanz_model_Column.h"

SPEC_BEGIN(ColumnSpec)

    __block Column* column;

    beforeEach(^{
        column = [[Column alloc]
            initWithColumnId:@"1" field:@"firstName" label:@"Customer First Name" dataType:ExpanzDataTypeString width:70];
    });

    describe(@"Object creation.", ^{

        it(@"should allow creation with firstName, label, dataType & width attributes", ^{
            assertThat(column, notNilValue());
            assertThat(column.field, equalTo(@"firstName"));
            assertThat(column.label, equalTo(@"Customer First Name"));
            assertThatInt(column.dataType, equalToInt(ExpanzDataTypeString));
            assertThatInt(column.width, equalToInt(70));
        });
    });

    afterEach(^{
        [column release];
    });
    

    SPEC_END