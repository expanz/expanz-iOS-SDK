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
#import "expanz_model_ActivityInstance.h"


SPEC_BEGIN(RXMLElement_ActivityInstanceSpec)

__block RXMLElement* activityElement;

describe(@"Object creation", ^{
        
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

describe(@"An activity with messages.", ^{
    
    beforeEach(^{
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"ActivityWithMessage" ofType:@"xml"]; 
        NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString]; 
        activityElement = [rootElement child:@"ExecXResult.ESA.Activity"];                 
    });
    
    it(@"should add a message for each message in the xml response", ^{
        ActivityInstance* activityInstance = [activityElement asActivityInstance]; 
        assertThatInt([activityInstance.messages count], equalToInt(1));
    });

    
});

describe(@"Error handling", ^{
    
    __block RXMLElement* e; 
    
    beforeEach(^{
        e = [RXMLElement elementFromXMLString:@"<wrong><xml>this is the wrong xml.</xml></wrong>"]; 
    });
    
    it(@"should throw NSException if you feed it the wrong kind of activity.", ^{

        @try {
            [e asActivityInstance]; 
            [NSException raise:@"Should have thrown exception" format:@"Fed the wrong kind of element"];
        }
        @catch (NSException* exception) {
            assertThat([exception name], equalTo(ExXmlValidationException));
        }
        
    });
    
    it(@"should throw NSException if you feed it the wrong kind of field.", ^{
        @try {
            [e asField]; 
            [NSException raise:@"Should have thrown exception" format:@"Fed the wrong kind of element"];
        }
        @catch (NSException* exception) {
            assertThat([exception name], equalTo(ExXmlValidationException));
        }
    });
    
    it(@"should NSException if you feed it the wrong kind of messages.", ^{
        @try {
            [e asMessage]; 
            [NSException raise:@"Should have thrown exception" format:@"Fed the wrong kind of element"];
        }
        @catch (NSException* exception) {
            assertThat([exception name], equalTo(ExXmlValidationException));
        }

    });
    
});


SPEC_END