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
#import "expanz_model_ActivitySchema.h"
#import "expanz_model_MethodSchema.h"


@implementation expanz_model_ActivitySchema

/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _fields = [[NSMutableArray alloc] init];
        _methods = [[NSMutableArray alloc] init];
        _styles = [[NSMutableArray alloc] init];
        _queries = [[NSMutableArray alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) fields {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [_fields sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (NSArray*) methods {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [_methods sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (NSArray*) styles {
    return nil;
}

- (NSArray*) queries {
    return nil;
}

- (void) addField:(expanz_model_FieldInstance*)field {
    [_fields addObject:field];

}

- (void) addMethod:(expanz_model_MethodSchema*)method {
    [_methods addObject:method];
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"ActivitySchema: fields=%@, methods=%@, styles=%@, queries=%@", _fields,
                                      _methods, _styles, _queries];
}


@end