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

#import "RXMLElement+ListAvailableSites.h"
#import "expanz_model_AppSite.h"
#import "expanz_model_SiteList.h"



@implementation RXMLElement (ListAvailableSites)


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


@end