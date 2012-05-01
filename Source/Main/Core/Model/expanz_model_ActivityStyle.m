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
        _formLayout = formLayout;
        if (name == nil) {
            _name = @"";
        }
        else if ([[name lowercaseString] isEqualToString:@"browse"]) {
            _name = @"Browse";
            _formLayout = SummaryListLayoutStyle;
        }
        else {
            _name = [name copy];
        }
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


@end