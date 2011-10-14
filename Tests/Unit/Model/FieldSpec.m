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
#import "expanz_model_Field.h"

SPEC_BEGIN(FieldSpec)

describe(@"Object creation.", ^{
    
    __block Field* field; 
    
    beforeEach(^{
        field = [[Field alloc] initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:@"number"]; 
    });
    
    it(@"should allow initialization with fieldId, nullable, defaultValue and datatype attributes.", ^{
        assertThat([field fieldId], equalTo(@"op1")); 
        assertThatBool([field isNullable], equalToBool(NO)); 
        assertThat([field defaultValue], nilValue()); 
        assertThat([field datatype], equalTo(@"number"));
    });
    
    afterEach(^{
        [field release];
    });
    
});


SPEC_END