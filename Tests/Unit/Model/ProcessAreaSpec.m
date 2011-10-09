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


SPEC_BEGIN(ProcessAreaSpec)

describe(@"Object initialization", ^{
        
    it(@"should allow initialization with process id and title attributes.", ^{
        ProcessArea* processArea = [[ProcessArea alloc] initWithProcessId:@"Calculator" andTitle:@"Calculator"]; 
        assertThat(processArea.processId, equalTo(@"Calculator"));
        assertThat(processArea.title, equalTo(@"Calculator"));        
        [processArea release];
    });
    
    it(@"should allow initialization from XML", ^{
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"SessionData" ofType:@"xml"]; 
        NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        RXMLElement* element = [RXMLElement elementFromXMLString:xmlString]; 
        
        [element iterate:@"ExecXResult.ESA.Menu.*" with: ^(RXMLElement* e) {
            ProcessArea* processArea = [e asProcessArea];
            LogDebug(@"%@", [processArea description]);

        }];
        

    });
    
    
});

SPEC_END