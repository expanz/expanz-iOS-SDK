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

#import "ActivityHarnessApplicationDelegate.h"
#import "expanz_ui_SystemEventReporter.h"
#import "expanz_ui_AlertBoxSystemEventReporter.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_model_ActivityInstance.h"
#import "RXMLElement+ActivityInstance.h"
#import "expanz_utils_BundleResource.h"
#import "expanz_model_ActivityStyle.h"
#import "expanz_model_menuItem.h"


//#define ACTIVITY_NAME   @"Thermomix.TMXConsultant.MyDetails"
//#define DATA_FILE       @"Thermomix.TMXConsultant_MyDetails.xml"
//#define ACTIVITY_STYLE  @""

//#define ACTIVITY_NAME   @"Thermomix.DocumentMaintenance.Portal"
//#define DATA_FILE       @"Thermomix_DocumentMaintenance_Portal_ActivityInstance.xml"
//#define ACTIVITY_STYLE  @""

//#define ACTIVITY_NAME   @"erp365CRM.Company.Browse"
//#define DATA_FILE       @"erp365CRM.Customer.Browse.xml"
//#define ACTIVITY_STYLE  @""

#define ACTIVITY_NAME   @"erp365CRM.Person.Browse"
#define DATA_FILE       @"erp365CRM.Person.Browse.xml"
#define ACTIVITY_STYLE  @""


@implementation ActivityHarnessApplicationDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;


- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _navigationController = [[UINavigationController alloc] init];
    [_window addSubview:_navigationController.view];

    NavigationManager* navigationManager = [[NavigationManager alloc] init];
    navigationManager.reporter = [[AlertBoxSystemEventReporter alloc] init];
    MenuItem* menuItem =
            [[MenuItem alloc] initWithActivityId:ACTIVITY_NAME title:@"Stub" style:[ActivityStyle defaultStyle]];

    [navigationManager showActivity:menuItem];
    [_window makeKeyAndVisible];

    NSString* data = [expanz_utils_BundleResource withName:DATA_FILE];
    //LogDebug(@"Activity data: %@", data);
    RXMLElement* element = [RXMLElement elementFromXMLString:data];
    ActivityInstanceViewController
            * controller = (ActivityInstanceViewController*) [_navigationController topViewController];
    ActivityInstance* activityInstance = [[element child:@"ExecXResult.ESA.Activity"] asActivityInstance];
    LogDebug(@"Activity instance: %@", activityInstance);

    //Force controller to be ready
    [controller view];
    [controller requestDidFinishWithActivityInstance:activityInstance];
    return YES;
}


@end
