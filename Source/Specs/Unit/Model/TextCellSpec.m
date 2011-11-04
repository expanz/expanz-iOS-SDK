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
#import "expanz_model_TextCell.h"
#import "expanz_model_ImageCell.h"

SPEC_BEGIN(TextCellSpec)

    __block TextCell* cell;

    beforeEach(^{

        cell = [[TextCell alloc] initWithCellId:@"firstName" text:@"Jasper"];
    });

    describe(@"Object creation", ^{

        it(@"should allow initialization with cellId and data attributes.", ^{
            assertThat(cell, notNilValue());
            assertThat(cell.cellId, equalTo(@"firstName"));
            assertThat(cell.text, equalTo(@"Jasper"));
        });
    });

    afterEach(^{
        [cell release];
    });



    SPEC_END