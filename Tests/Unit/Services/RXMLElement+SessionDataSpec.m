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

SPEC_BEGIN(RXMLELement_GetSessionData)

describe(@"Object instanciation", ^{
    
    __block RXMLElement* element;

    beforeEach(^{
        NSString* filePath = [[NSBundle mainBundle] pathForResource:@"SessionData" ofType:@"xml"]; 
        NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        element = [RXMLElement elementFromXMLString:xmlString]; 
    });
    
    it(@"should return a menu instance for from XML data.", ^{        
        Menu* menu = [[element child:@"ExecXResult.ESA.Menu"] asMenu]; 
        LogDebug(@"%@", menu);    
        assertThat(menu, notNilValue());
    });
    
});



SPEC_END