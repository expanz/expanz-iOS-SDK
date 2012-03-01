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
@synthesize class = _class;
@synthesize label = _label;

/* ================================================== Initializers ================================================== */
- (id) initWithName:(NSString*)name class:(NSString*)class label:(NSString*)label {
    self = [super init];
    if (self) {
        _name = name;
        _class = class;
        _label = label;
    }

    return self;
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"FieldSchema: name=%@, class=%@, label=%@", _name, _class, _label];
}


@end