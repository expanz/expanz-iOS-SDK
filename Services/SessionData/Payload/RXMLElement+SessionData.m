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

@implementation RXMLElement (RXMLElement_SessionData)


/* ================================================ Interface Methods =============================================== */

- (ProcessArea*) asProcessArea  {
    if ([self.tag isEqualToString:@"ProcessArea"]) {
        ProcessArea* processArea = [[[ProcessArea alloc] initWithProcessId:[self attribute:@"id"] 
                                              andTitle:[self attribute:@"title"]] autorelease];
        [self iterate:@"*" with: ^(RXMLElement* e) {
            Activity* activity = [[Activity alloc] initWithName:[e attribute:@"name"] andTitle:[e attribute:@"title"]];
            [processArea addActivity:activity];
            [activity release];
        }];        
        return processArea;
    }
    return nil;    
}



@end
