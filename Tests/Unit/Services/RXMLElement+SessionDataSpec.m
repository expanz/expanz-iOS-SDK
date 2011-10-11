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

it(@"should return a menu instance for from XML data.", ^{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"SessionData" ofType:@"xml"]; 
    NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    RXMLElement* element = [RXMLElement elementFromXMLString:xmlString]; 
    Menu* menu = [[element child:@"ExecXResult.ESA.Menu"] asMenu]; 
    LogDebug(@"%@", menu);    
});


SPEC_END