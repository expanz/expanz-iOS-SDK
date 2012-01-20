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
#import "expanz_model_ActivityDefinition.h"


SPEC_BEGIN(ActivitySpec)

describe(@"Object instanciation", ^{
        
    it(@"should allow initialization with name and title.", ^{
        ActivityDefinition* activity = [[ActivityDefinition alloc] initWithName:@"Calculator" 
                                    title:@"Calculator Application" style:[ActivityStyle defaultStyle]];
        assertThat(activity.name, equalTo(@"Calculator"));
        assertThat(activity.title, equalTo(@"Calculator Application"));
        assertThat([activity description], notNilValue());
    });    
});

SPEC_END