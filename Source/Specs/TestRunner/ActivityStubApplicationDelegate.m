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

#import "ActivityStubApplicationDelegate.h"
#import "expanz_ui_SystemEventReporter.h"
#import "expanz_ui_AlertBoxSystemEventReporter.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_model_ActivityDefinition.h"

#define ACTIVITY_NAME   @"Sales.Customer"
#define DATA_FILE       @"ESA_Sales_Customer_ActivityInstance.xml"
#define ACTIVITY_STYLE  nil

@implementation ActivityStubApplicationDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;


- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    LogDebug(@"Here we go!");
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _navigationController = [[UINavigationController alloc] init];
    [_window addSubview:_navigationController.view];

    NavigationManager* navigationManager = [[NavigationManager alloc] init];
    navigationManager.reporter = [[AlertBoxSystemEventReporter alloc] init];
    ActivityDefinition* activityDefinition = [[ActivityDefinition alloc]
        initWithName:ACTIVITY_NAME title:@"Stub" style:[ActivityStyle defaultStyle]];

    LogDebug(@"Activity style: %@", activityDefinition.style.name);

    [navigationManager showActivityWithDefinition:activityDefinition];
    [_window makeKeyAndVisible];
    return YES;
}


@end
