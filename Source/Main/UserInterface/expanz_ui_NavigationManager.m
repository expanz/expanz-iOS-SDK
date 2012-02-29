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
#import "CAFilter+Unlock.h"
#import "expanz_model_ActivityMenuItem.h"
#import "expanz_AppDelegate.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_ui_ActivityMenuViewController.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_DocumentViewController.h"
#import "expanz_model_ActivityInstance.h"

/* ================================================================================================================== */
@interface expanz_ui_NavigationManager (private)

- (NSString*) nibNameFor:(ActivityMenuItem*)activityDefinition;

- (NSString*) controllerClassNameFor:(ActivityMenuItem*)activityDefinition;

- (CATransition*) cubeViewTransition;

@end

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
- (BOOL) showMainMenu {
    ActivityMenuViewController* menuViewController = [[ActivityMenuViewController alloc] init];
    [_navigationController pushViewController:menuViewController animated:NO];
    [_navigationController setNavigationBarHidden:NO];
    [menuViewController.navigationItem setHidesBackButton:YES];

    SdkAppDelegate* delegate = [UIApplication sharedApplication].delegate;
    [delegate.window.layer addAnimation:[self cubeViewTransition] forKey:nil];
    [delegate.window addSubview:delegate.navigationController.view];
    return YES;
}


- (BOOL) showActivityWithDefinition:(expanz_model_ActivityMenuItem*)activityDefinition {
    return [self showActivityWithDefinition:activityDefinition initialKey:nil];
}

- (BOOL)   showActivityWithDefinition:(expanz_model_ActivityMenuItem*)activityDefinition
                         initialKey:(NSString*)initialKey {

    NSString* controllerClassName = [self controllerClassNameFor:activityDefinition];
    id clazz = objc_getClass([controllerClassName cStringUsingEncoding:NSASCIIStringEncoding]);
    if (clazz == nil) {
        NSString* errorMessage = [NSString stringWithFormat:@"No controller exists named %@", controllerClassName];
        [_reporter reportErrorWithReason:errorMessage];
        return NO;
    }
    else {
        ActivityInstanceViewController* nextView = [clazz alloc];
        NSString* nibName = [self nibNameFor:activityDefinition];
        nextView = [nextView initWithActivityDefinition:activityDefinition nibName:nibName initialKey:initialKey];
        [_navigationController pushViewController:nextView animated:YES];
        return YES;
    }
}

- (BOOL) showDocument:(NSString*)documentId {
    ActivityInstanceViewController
        * currentActivity = (ActivityInstanceViewController*) [_navigationController topViewController];
    NSString* activityHandle = [currentActivity activityInstance].handle;

    DocumentViewController* documentViewController =
        [[DocumentViewController alloc] initWithDocumentId:documentId activityHandle:activityHandle];
    [_navigationController pushViewController:documentViewController animated:YES];
    return YES;
}


/* ================================================== Private Methods =============================================== */
- (NSString*) nibNameFor:(ActivityMenuItem*)activityDefinition {
    NSString* nibName;
    if ([activityDefinition.style isDefault]) {
        nibName = activityDefinition.activityId;
    }
    else {
        nibName = [NSString stringWithFormat:@"%@.%@", activityDefinition.activityId, activityDefinition.style.name];
    }
    LogDebug(@"Nib name: %@", nibName);
    return nibName;
}

- (NSString*) controllerClassNameFor:(ActivityMenuItem*)activityDefinition {
    NSMutableString* controllerClassName = [NSMutableString
        stringWithString:[activityDefinition.activityId stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    if (![activityDefinition.style isDefault]) {
        [controllerClassName appendString:[NSString stringWithFormat:@"_%@", activityDefinition.style.name]];
    }
    [controllerClassName appendString:@"_ViewController"];
    LogDebug(@"Controller class name: %@", controllerClassName);
    return controllerClassName;
}

//TODO: Private API - replace this with library call.
- (CATransition*) cubeViewTransition {
    static const NSTimeInterval kAnimationDuration = 0.75f;
    CATransition* transition = [CATransition animation];
    transition.duration = kAnimationDuration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    CAFilter* filter = [CAFilter filterWithName:@"cube"];
    [filter setValue:[NSValue valueWithCGPoint:CGPointMake(160, 240)] forKey:@"inputPosition"];
    transition.filter = filter;
    return transition;
}


@end