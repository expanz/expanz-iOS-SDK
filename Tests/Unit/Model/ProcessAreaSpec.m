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

#import "RXMLElement+SessionData.h"
#import "expanz_model_ProcessArea.h"
#import "expanz_model_ActivityMenuItem.h"


SPEC_BEGIN(ProcessAreaSpec)

describe(@"Object initialization", ^{
        
    it(@"should allow initialization with process id and title attributes.", ^{
        ProcessArea* processArea = [[ProcessArea alloc] initWithProcessId:@"Calculator" andTitle:@"Calculator"];
        [[processArea.processId should] equal:@"Calculator"];
        [[processArea.title should] equal:@"Calculator"];
        [[processArea description] shouldNotBeNil];

    });        
});

describe(@"Activities", ^{
    
    __block ProcessArea* processArea;
    
    beforeEach(^{
        processArea = [[ProcessArea alloc] initWithProcessId:@"123" andTitle:@"My Process"];
    });
    
    it(@"should contain an activities property, that is initialized empty. ", ^{
        [[processArea.activities should] beEmpty];
    });
    
    it(@"should store references to associated activites via an addActivity method", ^{
        ActivityMenuItem* activity = [[ActivityMenuItem alloc] initWithActivityId:@"Order a widget"
                                                title:@"Get your widgets here" style:[ActivityStyle browseStyle]];
        [processArea addActivityDefinition:activity];
        [[processArea.activities should] haveCountOf:1];
    });
    
    it(@"should allow retrieving an activity by name.", ^{
        ActivityMenuItem* activity = [[ActivityMenuItem alloc] initWithActivityId:@"Order a widget"
                                                title:@"Get your widgets here" style:[ActivityStyle browseStyle]];
        [processArea addActivityDefinition:activity];

        [[[processArea activityWithName:@"Order a widget"] should] equal:activity];
        [[processArea activityWithName:@"zzzzzz"] shouldBeNil];
    });

});

SPEC_END