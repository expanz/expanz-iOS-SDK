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

/* ================================================= Class Methods ================================================== */
+ (expanz_model_ActivityStyle*)defaultStyle {
    return [[[ActivityStyle alloc] initWithName:nil] autorelease];
}

+ (expanz_model_ActivityStyle*)browseStyle {
    return [[[ActivityStyle alloc] initWithName:@"browse"] autorelease];
}

+ (expanz_model_ActivityStyle*)fromString:(NSString*)string {
    return [[[ActivityStyle alloc] initWithName:string] autorelease];
}

/* ================================================== Initializers ================================================== */
- (id)initWithName:(NSString*)name {
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
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */

- (BOOL)isDefault {
    return [[_name lowercaseString] isEqualToString:@""];
}

- (BOOL)isBrowse {
    return [[_name lowercaseString] isEqualToString:@"browse"];
}

/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [_name release];
    [super dealloc];
}

@end