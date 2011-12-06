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
#import <Objection-iOS/Objection.h>
#import "expanz_model_ActivityDefinition.h"
#import "expanz_iOS_SDKAppDelegate.h"
#import "expanz_ui_NavigationManager.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_DocumentViewController.h"


/* ================================================================================================================== */
@interface expanz_ui_NavigationManager (private)

- (NSString*)nibNameFor:(ActivityDefinition*)activityDefinition;

- (NSString*)controllerClassNameFor:(ActivityDefinition*)activityDefinition;

@end

/* ================================================================================================================== */
@implementation expanz_ui_NavigationManager

objection_register_singleton(expanz_ui_NavigationManager)
objection_requires(@"reporter")

@synthesize reporter = _reporter;


/* ================================================== Constructors ================================================== */
- (id)init {
    self = [super init];
    if (self) {
        SDKAppDelegate* appDelegate = [UIApplication sharedApplication].delegate;
        _navigationController = appDelegate.navigationController;
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (BOOL)transitionToActivityWithDefinition:(expanz_model_ActivityDefinition*)activity {

    return [self transitionToActivityWithDefinition:activity initialKey:nil];
}

- (BOOL)transitionToActivityWithDefinition:(expanz_model_ActivityDefinition*)activity
                                initialKey:(NSString*)initialKey {

    NSString* controllerClassName = [self controllerClassNameFor:activity];
    id clazz = objc_getClass([controllerClassName cStringUsingEncoding:NSASCIIStringEncoding]);
    if (clazz == nil) {
        NSString* errorMessage = [NSString stringWithFormat:@"No controller exists named %@", controllerClassName];
        [_reporter reportErrorWithReason:errorMessage];
        return NO;
    }
    else {
        ActivityInstanceViewController* nextView = class_createInstance(clazz, 0);
        NSString* nibName = [self nibNameFor:activity];
        nextView = [nextView initWithActivityDefinition:activity nibName:nibName initialKey:initialKey];
        [_navigationController pushViewController:nextView animated:YES];
        [nextView release];
        return YES;
    }
}


- (BOOL)transitionToDocumentView {
    DocumentViewController* documentViewController =
        [[DocumentViewController alloc] initWithNibName:@"DocumentView" bundle:[NSBundle mainBundle]];
    [_navigationController pushViewController:documentViewController animated:YES];
    [documentViewController release];
    return YES;
}

/* ================================================== Private Methods =============================================== */
- (NSString*)nibNameFor:(expanz_model_ActivityDefinition*)activityDefinition {
    NSString* nibName;
    if ([activityDefinition.style isDefault]) {
        nibName = activityDefinition.name;
    }
    else {
        nibName = [NSString stringWithFormat:@"%@.%@", activityDefinition.name, activityDefinition.style.name];
    }
    return nibName;
}

- (NSString*)controllerClassNameFor:(ActivityDefinition*)activityDefinition {
    NSMutableString* controllerClassName = [NSMutableString
        stringWithString:[activityDefinition.name stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    if (![activityDefinition.style isDefault]) {
        [controllerClassName appendString:[NSString stringWithFormat:@"_%@", activityDefinition.style.name]];
    }
    [controllerClassName appendString:@"_ViewController"];
    return controllerClassName;
}

/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [_reporter release];
    [super dealloc];
}


@end