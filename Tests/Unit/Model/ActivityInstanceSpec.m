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
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"


SPEC_BEGIN(ActivityInstanceSpec)

__block ActivityInstance* instance; 

beforeEach(^{
    instance = [[ActivityInstance alloc] initWithTitle:@"Calculator" handle:@"12345" persistentId:@"123"];
});

describe(@"Object creation.", ^{
    
    it(@"should allow initialization with title, handle and persistent id", ^{
        assertThat(instance.title, equalTo(@"Calculator"));
        assertThat(instance.handle, equalTo(@"12345"));
        assertThat(instance.persistentId, equalTo(@"123"));     
    });
        
});

describe(@"Relationship to fields", ^{

    it(@"should store a collection of field objects, initially empty.", ^{
        assertThat([instance fields], empty());
    });
    
    it(@"should allow field references to be added.", ^{
        Field* field = [[Field alloc] initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:@"number"];
        [instance addField:field]; 
        [field release];
        assertThatInt([instance.fields count], equalToInt(1)); 
    });
    
    it(@"should allow a stored field to be retrieved by fieldId", ^{
        Field* field = [[Field alloc] initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:@"number"];
        [instance addField:field]; 
        [field release];
        
        Field* retrieved = [instance fieldWithId:@"op1"];
        assertThat(retrieved, equalTo(field));
        
        Field* another = [instance fieldWithId:@"notInMyCollection"];
        assertThat(another, nilValue());
    });
    
    it(@"should prevent method invocations, unless all of it's child fields are clean.", ^{
        
        it(@"should allow method invocations when it doesn't have any fields. ", ^{
            assertThatBool([instance allowsMethodInvocations], equalToBool(YES));
        });

        it(@"should allow method invocations when it's one field is clean", ^{
            Field* field = [[Field alloc] initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:@"number"];
            //Field is clean. 
            assertThatBool(field.isDirty, equalToBool(NO));
            [instance addField:field];
            [field release];
            assertThatBool([instance allowsMethodInvocations], equalToBool(YES));
        });
        
        
        it(@"should disallow method invocations, when one or more if it's child fields is dirty.", ^{
            Field* another = [[Field alloc] initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:@"number"];
            //Make the field dirty. 
            [another userDidEditWithValue:@"One two three"]; assertThatBool([another isDirty], equalToBool(YES));
            [instance addField:another];
            [another release];
            
            assertThatBool([instance allowsMethodInvocations], equalToBool(NO)); 
        });
        
        
    });

});


afterEach(^{
    [instance release]; 
});


SPEC_END