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

#import "expanz_model_ActivityMenuItem.h"


SPEC_BEGIN(ActivitySpec)

describe(@"Object instanciation", ^{
        
    it(@"should allow initialization with name and title.", ^{
        ActivityMenuItem* activity = [[ActivityMenuItem alloc] initWithActivityId:@"CALC"
                                    title:@"Calculator Application" style:[ActivityStyle defaultStyle]];
        [[[activity activityId] should] equal:@"CALC"];
        [[[activity title] should] equal:@"Calculator Application"];
        [[activity description] shouldNotBeNil];
    });    
});

SPEC_END