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


#import <objc/runtime.h>
#import "UITableView+DataPublication.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_AppDelegate.h"

static char const* const fieldNameskey = "fieldNames";

/* ================================================================================================================== */
@interface UITableView (DataPublication_private)

- (ActivityInstanceViewController*) activityController;

@end

/* ================================================================================================================== */
@implementation UITableView (DataPublication)

- (void) setExpanzDataBinding:(BOOL)dataBinding {
    ActivityInstanceViewController* activityController = [self activityController];
    [activityController hasUITableView:self requestingDataBinding:dataBinding];
}

- (void) setPopulateMethod:(NSString*)populateMethod {
    ActivityInstanceViewController* activityController = [self activityController];
    [activityController hasUITableView:self requestingDataBinding:YES];
    [activityController hasUITableView:self requestingPopulateMethod:populateMethod];
}

- (void) setQuery:(NSString*)query {
    ActivityInstanceViewController* activityController = [self activityController];
    [activityController hasUITableView:self requestingDataBinding:YES];
    [activityController hasUITableView:self requestingQuery:query];
}

- (void) setAutoPopulate:(BOOL)autoPopulate {
    ActivityInstanceViewController* activityController = [self activityController];
    [activityController hasUITableView:self requestingDataBinding:YES];
    [activityController hasUITableView:self requestingAutoPopulate:autoPopulate];
}

- (void) setFieldNames:(NSString*)fieldNames {
    objc_setAssociatedObject(self, fieldNameskey, [fieldNames componentsSeparatedByString:@","],
        OBJC_ASSOCIATION_RETAIN_NONATOMIC);

}

- (NSArray*) fieldNames {
    return objc_getAssociatedObject(self, fieldNameskey);
}



/* ================================================== Private Methods =============================================== */

- (ActivityInstanceViewController*) activityController {
    id appDelegate = (SdkAppDelegate*) [UIApplication sharedApplication].delegate;
    return (ActivityInstanceViewController*) [appDelegate navigationController].topViewController;
}

@end