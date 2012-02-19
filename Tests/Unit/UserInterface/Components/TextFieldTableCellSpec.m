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

#import "expanz_ui_components_TextFieldTableCell.h"

SPEC_BEGIN(TextFieldTableCellSpec)

describe(@"Object creation", ^{
    
    it(@"should allow initialization with reusde identifier", ^{
        TextFieldTableCell* tableCell = [[TextFieldTableCell alloc] init];
        [tableCell shouldNotBeNil];
    });

});


SPEC_END