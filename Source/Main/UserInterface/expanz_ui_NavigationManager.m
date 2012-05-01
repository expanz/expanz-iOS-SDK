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
#import "Objection.h"
#import "expanz_model_menuItem.h"
#import "expanz_AppDelegate.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_ui_ActivityMenuViewController.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_DocumentViewController.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_ui_ActivityControllerBuilder.h"

/* ================================================================================================================== */
@implementation expanz_ui_NavigationManager

objection_register_singleton(expanz_ui_NavigationManager)
objection_requires(@"reporter")

@synthesize reporter = _reporter;


/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        SdkAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        _navigationController = appDelegate.navigationController;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (ActivityMenuViewController*) showMainMenu {
    ActivityMenuViewController* menuViewController = [[ActivityMenuViewController alloc] init];
    [_navigationController pushViewController:menuViewController animated:YES];
    [_navigationController setNavigationBarHidden:NO];
    [menuViewController.navigationItem setHidesBackButton:YES];

    SdkAppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [delegate.window addSubview:delegate.navigationController.view];
    return menuViewController;
}


- (ActivityInstanceViewController*) showActivityFor:(MenuItem*)menuItem {
    return [self showActivityFor:menuItem initialKey:nil];
}

- (ActivityInstanceViewController*) showActivityFor:(MenuItem*)menuItem initialKey:(NSString*)initialKey {

    ActivityControllerBuilder* controllerBuilder = [ActivityControllerBuilder forActivityId:menuItem.activityId];
    [controllerBuilder setTitle:menuItem.title];
    [controllerBuilder setStyle:menuItem.style];
    [controllerBuilder setInitialKey:initialKey];
    [controllerBuilder setShouldAttachToServer:YES];
    ActivityInstanceViewController* nextViewController = [controllerBuilder build];

    if (nextViewController) {
        [_navigationController pushViewController:nextViewController animated:YES];
        return nextViewController;
    }
    else {
        NSString* errorMessage =
                [NSString stringWithFormat:@"No controller exists for activity: %@", menuItem.activityId];
        [_reporter reportErrorWithReason:errorMessage];
        return nil;
    }
}

- (DocumentViewController*) showDocument:(NSString*)documentId {
    NSString* activityHandle =
            [(ActivityInstanceViewController*) [_navigationController topViewController] activityInstance].handle;

    DocumentViewController* documentViewController =
            [[DocumentViewController alloc] initWithDocumentId:documentId activityHandle:activityHandle];
    [_navigationController pushViewController:documentViewController animated:YES];
    return documentViewController;
}


@end