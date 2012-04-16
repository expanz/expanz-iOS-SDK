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

#import "expanz_model_TextGridDataCell.h"

SPEC_BEGIN(TextCellSpec)

    __block TextGridDataCell* cell;

    beforeEach(^{

        cell = [[TextGridDataCell alloc] initWithCellId:@"firstName" text:@"Jasper"];
    });

    describe(@"Object creation", ^{

        it(@"should allow initialization with cellId and data attributes.", ^{
            [cell shouldNotBeNil];
            [[[cell cellId] should] equal:@"firstName"];
            [[[cell text] should] equal:@"Jasper"];
        });
    });


SPEC_END