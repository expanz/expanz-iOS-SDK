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
#import "../../../Main/Model/expanz_model_TextGridDataCell.h"
#import "../../../Main/Model/expanz_model_ImageGridDataCell.h"

SPEC_BEGIN(TextCellSpec)

    __block TextGridDataCell* cell;

    beforeEach(^{

        cell = [[TextGridDataCell alloc] initWithCellId:@"firstName" text:@"Jasper"];
    });

    describe(@"Object creation", ^{

        it(@"should allow initialization with cellId and data attributes.", ^{
            assertThat(cell, notNilValue());
            assertThat(cell.cellId, equalTo(@"firstName"));
            assertThat(cell.text, equalTo(@"Jasper"));
        });
    });




    SPEC_END