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
#import "expanz_model_ActivityStyle.h"

@implementation expanz_model_ActivityStyle


@synthesize name = _name;
@synthesize formLayout = _formLayout;

/* ================================================= Class Methods ================================================== */
+ (expanz_model_ActivityStyle*) defaultStyle {
    return [[ActivityStyle alloc] initWithName:nil];
}

+ (expanz_model_ActivityStyle*) browseStyle {
    return [[ActivityStyle alloc] initWithName:@"browse"];
}

+ (expanz_model_ActivityStyle*) fromString:(NSString*)string {
    return [[ActivityStyle alloc] initWithName:string];
}

/* ================================================== Initializers ================================================== */
- (id) initWithName:(NSString*)name {
    return [self initWithName:name formLayout:DetailLayoutStyle];
}

- (id) initWithName:(NSString*)name formLayout:(ActivityStyleFormLayout)formLayout {
    self = [super init];
    if (self) {
        if (name == nil) {
            _name = @"";
        }
        else if ([[name lowercaseString] isEqualToString:@"browse"]) {
            _name = @"Browse";
        }
        else {
            _name = [name copy];
        }
        _formLayout = formLayout;
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */

- (BOOL) isDefault {
    return [_name isEqualToString:@""];
}

- (BOOL) isBrowse {
    return [[_name lowercaseString] isEqualToString:@"browse"];
}

- (NSString*) controllerClassNameForActivityId:(NSString*)activityId {
    NSMutableString* controllerClassName = [NSMutableString
            stringWithString:[activityId stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    if (![self isDefault]) {
        [controllerClassName appendString:[NSString stringWithFormat:@"_%@", self.name]];
    }
    [controllerClassName appendString:@"_ViewController"];
    LogDebug(@"Controller class name: %@", controllerClassName);
    return controllerClassName;

}

- (NSString*) nibNameForActivityId:(NSString*)activityId {
    NSString* nibName;
    if ([self isDefault]) {
        nibName = activityId;
    }
    else {
        nibName = [NSString stringWithFormat:@"%@.%@", activityId, self.name];
    }
    LogDebug(@"Nib name: %@", nibName);
    return nibName;

}


@end