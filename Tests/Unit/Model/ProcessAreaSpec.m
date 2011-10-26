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
#import "RXMLElement+SessionData.h"
#import "expanz_model_ProcessArea.h"
#import "expanz_model_Activity.h"


SPEC_BEGIN(ProcessAreaSpec)

describe(@"Object initialization", ^{
        
    it(@"should allow initialization with process id and title attributes.", ^{
        ProcessArea* processArea = [[ProcessArea alloc] initWithProcessId:@"Calculator" andTitle:@"Calculator"]; 
        assertThat(processArea.processId, equalTo(@"Calculator"));
        assertThat(processArea.title, equalTo(@"Calculator"));        
        assertThat([processArea description], notNilValue());
        [processArea release];
    });        
});

describe(@"Activities", ^{
    
    __block ProcessArea* processArea;
    
    beforeEach(^{
        processArea = [[ProcessArea alloc] initWithProcessId:@"123" andTitle:@"My Process"];
    });
    
    it(@"should contain an activities property, that is initialized empty. ", ^{
        assertThat(processArea.activities, hasCountOf(0));
    });
    
    it(@"should store references to associated activites via an addActivity method", ^{
        Activity* activity = [[Activity alloc] initWithName:@"Order a widget" andTitle:@"Get your widgets here"];
        [processArea addActivity:activity];
        assertThat(processArea.activities, hasCountOf(1));
    });
    
    it(@"should allow retrieving an activity by name.", ^{
        Activity* activity = [[Activity alloc] initWithName:@"Order a widget" andTitle:@"Get your widgets here"];
        [processArea addActivity:activity];

        assertThat([processArea activityWithName:@"Order a widget"], equalTo(activity));
        assertThat([processArea activityWithName:@"zzzzzz"], nilValue());
    });
    
    afterEach(^{    
        [processArea release];
    });
});

SPEC_END