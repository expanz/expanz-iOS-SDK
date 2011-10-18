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
#import "expanz_ui_components_TextFieldTableCell.h"

SPEC_BEGIN(TestFieldTableCellSpec)

describe(@"Object creation", ^{
    
    it(@"should allow initialization with reusde identifier", ^{
        TextFieldTableCell* tableCell = [[[TextFieldTableCell alloc] initWithReuseIdentifier:@"CellXY"] autorelease];
        assertThat(tableCell, notNilValue());
    });

});

describe(@"Layout sub views", ^{

    it(@"should include a text field control in the table cell.", ^{
        TextFieldTableCell* tableCell = [[[TextFieldTableCell alloc] initWithReuseIdentifier:@"CellXY"] autorelease];
        [tableCell layoutSubviews]; 
        
        assertThat(tableCell.textField, notNilValue());
    });
});

SPEC_END