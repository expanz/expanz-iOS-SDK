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
#import "expanz_model_MethodSchema.h"
#import "expanz_model_FieldSchema.h"
#import "expanz_model_ActivityStyle.h"
#import "expanz_model_Query.h"

@implementation RXMLElement (SiteDetails)

/* ================================================================================================================== */
#pragma mark ActivityMenu

- (ActivityMenu*) asActivityMenu {
    if (![self.tag isEqualToString:@"Activities"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not an AppSite."];
    }

    ActivityMenu* activityList = [[ActivityMenu alloc] init];
    [self iterate:@"*" with:^(RXMLElement* element) {
        MenuItem* menuItem = [[MenuItem alloc]
                initWithActivityId:[element attribute:@"id"] title:[element attribute:@"name"] style:nil];
        [activityList addMenuItem:menuItem];
    }];
    return activityList;
}

/* ================================================================================================================== */
#pragma mark SiteList and children

- (SiteList*) asSiteList {
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

- (AppSite*) asAppSite {
    if (![self.tag isEqualToString:@"AppSite"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not an AppSite."];
    }
    return [[AppSite alloc] initWithAppSiteId:[self attribute:@"id"] name:[self attribute:@"name"]
            authenticationMode:[self attribute:@"authenticationMode"]];
}

/* ================================================================================================================== */
#pragma mark ActivitySchema and children

- (ActivitySchema*) asActivitySchema {
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

        else if ([e.tag isEqualToString:@"Style"]) {
            [activitySchema addStyle:[e asActivityStyle]];
        }

    }];
    return activitySchema;
}

- (FieldSchema*) asFieldSchema {
    if (![self.tag isEqualToString:@"Field"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not a Field."];
    }
    return [[FieldSchema alloc]
            initWithName:[self attribute:@"name"] expanzType:[self attribute:@"class"] label:[self attribute:@"label"]];
}

- (MethodSchema*) asMethodSchema {
    if (![self.tag isEqualToString:@"Method"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not a Method."];
    }
    return [[MethodSchema alloc] initWithName:[self attribute:@"name"] description:[self attribute:@"description"]];
}

- (ActivityStyle*) asActivityStyle {
    if (![self.tag isEqualToString:@"Style"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not a Style."];
    }
    ActivityStyleFormLayout formLayout;
    if ([[self attribute:@"defaultformlayout"] isEqualToString:@"SummaryList"]) {
        formLayout = SummaryListLayoutStyle;
    }
    else {
        formLayout = DetailLayoutStyle;
    }
    return [[ActivityStyle alloc] initWithName:[self attribute:@"name"] formLayout:formLayout];
}

- (Query*) asQuery {
    if (![self.tag isEqualToString:@"Query"]) {
        [NSException raise:NSInvalidArgumentException format:@"Element is not a Query."];
    }
    Query* query = [[Query alloc] initWithQueryId:[self attribute:@"id"]];

    [self iterate:@"*" with:^(RXMLElement* e) {
        FieldSchema* fieldSchema =
                [[FieldSchema alloc] initWithName:[e attribute:@"name"] expanzType:nil label:[e attribute:@"title"]];
        [query addField:fieldSchema];
    }];
    return query;
}

@end