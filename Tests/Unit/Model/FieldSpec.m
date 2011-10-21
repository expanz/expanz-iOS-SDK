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

describe(@"Editing", ^{
    
    __block Field* field; 
    
    beforeEach(^{
        field = [[Field alloc] initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:@"number"]; 
    });
    
    
    it(@"should include a method to set a new value, as a result of user interaction.", ^{
        [field userDidEditWithValue:@"new value"];
        
        assertThat(field.value, equalTo(@"new value"));
        
        it(@"should set a dirty flag to indicate the user changed a value, but the value has not yet been recieved \
           by the server",  ^{
               
               assertThatBool(field.isDirty, equalToBool(YES));
               
        });
        
        
    });
    
    
    it(@"should include a method to set a new value, as a result of server processing a delta request.", ^{
        [field completedStateChangeWithValidation:@"new validated value"]; 
        assertThat(field.value, equalTo(@"new validated value"));
                
        it(@"should revert back to a clean state, after the server has registered the delta. ", ^{
            assertThatBool(field.isDirty, equalToBool(NO));
            
        });

        
    });
    
    
    afterEach(^{
        [field release];
    });

});


SPEC_END