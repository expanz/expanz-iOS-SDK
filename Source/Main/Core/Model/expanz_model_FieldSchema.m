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
#import "expanz_model_FieldSchema.h"


@implementation expanz_model_FieldSchema

@synthesize name = _name;
@synthesize expanzType = _expanzType;
@synthesize label = _label;

/* ================================================== Initializers ================================================== */
- (id) initWithName:(NSString*)name expanzType:(NSString*)expanzType label:(NSString*)label {
    self = [super init];
    if (self) {
        _name = name;
        _expanzType = expanzType;
        _label = label;
    }

    return self;
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"FieldSchema: name=%@, expanzType=%@, label=%@", _name, _expanzType, _label];
}


@end