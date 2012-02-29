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
#import "RXMLElement+ListActivitiesForSite.h"
#import "expanz_model_ActivityMenu.h"

@implementation RXMLElement (ListActivitiesForSite)

- (expanz_model_ActivityMenu*) asActivityDefinitionList {
    if (![self.tag isEqualToString:@"Activities"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not an AppSite."];
    }

    ActivityMenu* activityList = [[ActivityMenu alloc] init];
    [self iterate:@"*" with:^(RXMLElement* element) {
        ActivityMenuItem* definition = [[ActivityMenuItem alloc]
            initWithActivityId:[element attribute:@"id"] title:[element attribute:@"name"] style:nil];
        [activityList addActivityDefinition:definition];
    }];
    return activityList;
}

@end