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
    it(@"should allow initialization with title, handle and persistent id", ^{
        ActivityInstance* instance = [[ActivityInstance alloc] initWithTitle:@"Calculator" handle:@"12345" 
                                                                persistentId:@"123"];
        assertThat(instance.title, equalTo(@"Calculator"));
        assertThat(instance.handle, equalTo(@"12345"));
        assertThat(instance.persistentId, equalTo(@"123"));     
        [instance release];
        
    });
});

SPEC_END