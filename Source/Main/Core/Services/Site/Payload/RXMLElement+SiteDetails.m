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
#import "RXMLElement+SiteDetails.h"
#import "expanz_model_ActivityMenu.h"
#import "expanz_model_SiteList.h"
#import "expanz_model_AppSite.h"
#import "expanz_model_ActivitySchema.h"

@implementation RXMLElement (SiteDetails)

- (expanz_model_ActivityMenu*) asActivityMenu {
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

- (expanz_model_SiteList*) asSiteList {
    if (![self.tag isEqualToString:@"AppSites"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not an AppSite."];
    }
    NSArray* children = [self children:@"AppSite"];
    LogDebug(@"Children: %@", children);
    SiteList* siteList = [[SiteList alloc] init];
    for (RXMLElement* element in children) {
        [siteList addSite:[element asAppSite]];
    }
    return siteList;
}

- (expanz_model_AppSite*) asAppSite {
    if (![self.tag isEqualToString:@"AppSite"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not an AppSite."];
    }
    return [[AppSite alloc] initWithAppSiteId:[self attribute:@"id"] name:[self attribute:@"name"]
                           authenticationMode:[self attribute:@"authenticationMode"]];
}

- (expanz_model_ActivitySchema*) asActivitySchema {
    if (![self.tag isEqualToString:@"Activity"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not an Activity."];
    }
    return [[ActivitySchema alloc] init];
}

@end