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

#import "NSString+ExpanzUtils.h"
#import "expanz_model_ActivityStyle.h"


@implementation NSString (ExpanzUtils)

+ (NSString*) controllerClassNameForActivityId:(NSString*)activityId style:(expanz_model_ActivityStyle*)style {

    NSMutableString* controllerClassName =
            [NSMutableString stringWithString:[activityId stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    if (![style isDefault]) {
        [controllerClassName appendString:[NSString stringWithFormat:@"_%@", style.name]];
    }
    [controllerClassName appendString:@"_ViewController"];
    LogDebug(@"Controller class name: %@", controllerClassName);
    return controllerClassName;

}

+ (NSString*) nibNameForActivityId:(NSString*)activityId style:(expanz_model_ActivityStyle*)style {

    NSString* nibName;
    if ([style isDefault]) {
        nibName = activityId;
    }
    else {
        nibName = [NSString stringWithFormat:@"%@.%@", activityId, style.name];
    }
    LogDebug(@"Nib name: %@", nibName);
    return nibName;
}

@end