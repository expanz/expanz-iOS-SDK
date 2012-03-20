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
#import "expanz_ui_FieldFilter.h"
#import "expanz_ui_QueryDataSource.h"
#import "JRSwizzle.h"

static char const* const fieldNameskey = "fieldNames";

/* ================================================================================================================== */
@interface UITableView (DataPublication_private)

- (ActivityInstanceViewController*) activityController;

@end

/* ================================================================================================================== */
@implementation UITableView (DataPublication)

+ (void) load {
    [[self class] jr_swizzleMethod:@selector(setDataSource:) withMethod:@selector(setMyDataSource:) error:nil];
    [super load];
}


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

- (NSArray*) fieldNames {
    return objc_getAssociatedObject(self, fieldNameskey);
}

- (void) setFieldFilter:(FieldFilter*)fieldFilter {
    objc_setAssociatedObject(self, fieldNameskey, [fieldFilter fields], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void) setMyDataSource:(id<UITableViewDataSource>)dataSource {
    if ([dataSource isKindOfClass:[QueryDataSource class]]) {
        QueryDataSource* queryDataSource = (QueryDataSource*) dataSource;
        LogDebug(@"Setting my query: %@", [queryDataSource query]);
        [self setQuery:[queryDataSource query]];
    }
    else {
        [[self class] jr_swizzleMethod:@selector(setMyDataSource:) withMethod:@selector(setDataSource:) error:nil];
        [self setDataSource:dataSource];
        [[self class] jr_swizzleMethod:@selector(setDataSource:) withMethod:@selector(setMyDataSource:) error:nil];
    }
}

- (FieldFilter*) fieldFilter {
    return nil;
}

/* ================================================== Private Methods =============================================== */

- (ActivityInstanceViewController*) activityController {
    id appDelegate = (SdkAppDelegate*) [UIApplication sharedApplication].delegate;
    UIViewController* topController = [appDelegate navigationController].topViewController;
    if ([topController isKindOfClass:([ActivityInstanceViewController class])]) {
        return (ActivityInstanceViewController*) topController;
    }
    return nil;
}

@end