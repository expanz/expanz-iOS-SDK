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

});


afterEach(^{
    [instance release]; 
});


SPEC_END