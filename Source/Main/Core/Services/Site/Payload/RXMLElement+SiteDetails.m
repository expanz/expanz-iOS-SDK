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
#import "RXMLElement+ActivityInstance.h"
#import "expanz_model_MethodSchema.h"
#import "expanz_model_FieldSchema.h"

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

    ActivitySchema* activitySchema =
            [[ActivitySchema alloc] initWithActivityId:[self attribute:@"id"] title:[self attribute:@"title"]];
    [self iterate:@"*" with:^(RXMLElement* e) {

        if ([e.tag isEqualToString:@"Field"]) {
            [activitySchema addField:[e asFieldSchema]];
        }

        else if ([e.tag isEqualToString:@"Method"]) {
            [activitySchema addMethod:[e asMethodSchema]];
        }

    }];
    return activitySchema;
}

- (expanz_model_FieldSchema*) asFieldSchema {
    if (![self.tag isEqualToString:@"Field"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not a Field."];
    }
    return [[FieldSchema alloc]
            initWithName:[self attribute:@"name"] expanzType:[self attribute:@"class"] label:[self attribute:@"label"]];

}

- (expanz_model_MethodSchema*) asMethodSchema {
    if (![self.tag isEqualToString:@"Method"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not a Method."];
    }
    return [[MethodSchema alloc] initWithName:[self attribute:@"name"] description:[self attribute:@"description"]];
}

@end