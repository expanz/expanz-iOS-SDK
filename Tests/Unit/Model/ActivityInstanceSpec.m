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


SPEC_BEGIN(ActivityInstanceSpec)

describe(@"Object creation.", ^{
    
    __block ActivityInstance* instance; 
    
    beforeEach(^{
        instance = [[ActivityInstance alloc] initWithTitle:@"Calculator" handle:@"12345" persistentId:@"123"];
    });
    
    it(@"should allow initialization with title, handle and persistent id", ^{
        assertThat(instance.title, equalTo(@"Calculator"));
        assertThat(instance.handle, equalTo(@"12345"));
        assertThat(instance.persistentId, equalTo(@"123"));     
    });
    
    it(@"should store a collection of field objects, initially empty.", ^{
        assertThat([instance fields], empty());
    });
    
    it(@"should allow field references to be added.", ^{
        Field* field = [[Field alloc] initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:@"number"];
        [instance addField:field]; 
        [field release];
        assertThatInt([instance.fields count], equalToInt(1)); 
    });
    
    afterEach(^{
        [instance release]; 
    });
    
});




SPEC_END