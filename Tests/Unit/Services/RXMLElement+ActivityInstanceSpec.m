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
#import "RXMLElement+ActivityInstance.h"

SPEC_BEGIN(RXMLElement_ActivityInstanceSpec)

describe(@"Object instanciation", ^{
    
    __block RXMLElement* activityElement;
    
    beforeEach(^{
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"ActivityDetails" ofType:@"xml"]; 
        NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString]; 
        activityElement = [rootElement child:@"ExecXResult.ESA.Activity"]; 
    });
    
    it(@"should return an ActivityIntance from corresponding XML", ^{
        ActivityInstance* activityInstance = [activityElement asActivityInstance]; 
        assertThat(activityInstance, notNilValue());                                              
    });
    
});


SPEC_END