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


#import "UITableView+DataPublication.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_iOS_SDKAppDelegate.h"

/* ================================================================================================================== */
@interface UITableView(DataPublication_private)

- (ActivityInstanceViewController*) activityController;

@end

/* ================================================================================================================== */
@implementation UITableView (DataPublication)

- (void) setDataPublicationId:(NSString*)dataPublicationId {
    ActivityInstanceViewController* activityController = [self activityController];
    [activityController hasUITableView:self requestingDataPublicationId:dataPublicationId];
}

- (void) setPopulateMethod:(NSString*)populateMethod {
    ActivityInstanceViewController* activityController = [self activityController];
    [activityController hasUITableView:self requestingPopulateMethod:populateMethod];
}

- (void) setAutoPopulate:(BOOL)autoPopulate {
    ActivityInstanceViewController* activityController = [self activityController];
    [activityController hasUITableView:self requestingAutoPopulate:autoPopulate];
}


/* ================================================== Private Methods =============================================== */

- (ActivityInstanceViewController*) activityController {
    SDKAppDelegate* appDelegate = (SDKAppDelegate*) [UIApplication sharedApplication].delegate;
    UINavigationController* navigationController = appDelegate.navigationController;
    UIViewController* topController = navigationController.topViewController;
    if ([topController isKindOfClass:[ActivityInstanceViewController class]]) {
        return (ActivityInstanceViewController*) topController;
    }
    return nil;
}

@end