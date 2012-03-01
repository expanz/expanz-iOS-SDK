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
#import "expanz_model_MethodSchema.h"


@implementation expanz_model_MethodSchema

@synthesize name = _name;
@synthesize description = _description;

- (id) initWithName:(NSString*)name description:(NSString*)description {
    self = [super init];
    if (self) {
        _name = [name copy];
        _description = [description copy];
    }
    return self;
}


@end