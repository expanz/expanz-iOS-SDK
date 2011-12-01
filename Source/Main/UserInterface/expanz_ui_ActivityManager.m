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
#import "expanz_ui_ActivityManager.h"
#import "expanz_model_ActivityDefinition.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_iOS_SDKAppDelegate.h"


/* ================================================================================================================== */
@interface expanz_ui_ActivityManager (private)

- (NSString*)nibNameFor:(ActivityDefinition*)activityDefinition;

- (NSString*)controllerClassNameFor:(ActivityDefinition*)activityDefinition;

@end

/* ================================================================================================================== */
@implementation expanz_ui_ActivityManager

objection_register_singleton(expanz_ui_ActivityManager)

- (BOOL)transitionToActivityWithDefinition:(expanz_model_ActivityDefinition*)activity {

    return [self transitionToActivityWithDefinition:activity initialKey:nil];
}

- (BOOL)transitionToActivityWithDefinition:(expanz_model_ActivityDefinition*)activity
                                initialKey:(NSString*)initialKey {

    NSString* controllerClassName = [self controllerClassNameFor:activity];
    id clazz = objc_getClass([controllerClassName cStringUsingEncoding:NSASCIIStringEncoding]);
    if (clazz == nil) {
        NSString* errorMessage = [NSString stringWithFormat:@"No controller exists named %@", controllerClassName];
        UIAlertView* alert = [[UIAlertView alloc]
            initWithTitle:@"Error" message:errorMessage delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return NO;
    }
    else {
        ActivityInstanceViewController* nextView = class_createInstance(clazz, 0);
        NSString* nibName = [self nibNameFor:activity];
        nextView = [nextView initWithActivityDefinition:activity nibName:nibName initialKey:initialKey];
        SDKAppDelegate* delegate = [UIApplication sharedApplication].delegate;
        [delegate.navigationController pushViewController:nextView animated:YES];
        [nextView release];
        return YES;
    }
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
    LogDebug(@"Nib name: %@", nibName);
    return nibName;
}

- (NSString*)controllerClassNameFor:(ActivityDefinition*)activityDefinition {
    //TODO: Look up view controller from formmapping.xml
    NSMutableString* controllerClassName = [NSMutableString stringWithString:
        [activityDefinition.name stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    if (![activityDefinition.style isDefault]) {
        [controllerClassName appendString:[NSString stringWithFormat:@"_%@", activityDefinition.style.name]];
    }
    [controllerClassName appendString:@"_ViewController"];
    return controllerClassName;
}


@end