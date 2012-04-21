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

#import "expanz_model_menuItem.h"


SPEC_BEGIN(ActivitySpec)

describe(@"Object instanciation", ^{
        
    it(@"should allow initialization with name and title.", ^{
        MenuItem* menuItem = [[MenuItem alloc] initWithActivityId:@"CALC"
                                    title:@"Calculator Application" style:[ActivityStyle defaultStyle]];
        [[[menuItem activityId] should] equal:@"CALC"];
        [[[menuItem title] should] equal:@"Calculator Application"];
        [[menuItem description] shouldNotBeNil];
    });    
});

SPEC_END