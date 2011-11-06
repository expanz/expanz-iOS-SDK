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
#import "expanz_ui_ActivityManager.h"
#import "expanz_model_ActivityDefinition.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_iOS_SDKAppDelegate.h"

@implementation expanz_ui_ActivityManager


+ (BOOL) transitionToActivityWithDefinition:(expanz_model_ActivityDefinition*)activity {

    return [ActivityManager
        transitionToActivityWithDefinition:activity initialKey:nil];
}

+ (BOOL) transitionToActivityWithDefinition:(expanz_model_ActivityDefinition*)activity
                                 initialKey:(NSString*)initialKey {

    //TODO: Look up view controller from formmapping.xml
    NSMutableString* controllerClassName = [[NSMutableString alloc] init];
    [controllerClassName appendString:[activity.name stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    [controllerClassName appendString:@"ViewController"];
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
        nextView = [nextView initWithActivityDefinition:activity initialKey:initialKey];
        SDKAppDelegate* delegate = [UIApplication sharedApplication].delegate;
        [delegate.navigationController pushViewController:nextView animated:YES];
        [nextView release];
        return YES;
    }
}

+ (NSString*) nibNameFor:(expanz_model_ActivityDefinition*)activityDefinition {
    NSString* nibName;
    if (activityDefinition.style == ActivityStyleBrowse) {
        nibName = [NSString stringWithFormat:@"%@.Browse", activityDefinition.name];
    }
    else {        
        nibName = activityDefinition.name;
    }
    LogDebug(@"Nib name: %@", nibName);
    return nibName;
}


@end