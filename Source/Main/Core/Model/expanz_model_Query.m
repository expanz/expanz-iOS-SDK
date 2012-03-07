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
#import "expanz_model_Query.h"
#import "expanz_model_FieldSchema.h"


@implementation expanz_model_Query

@synthesize queryId = _queryId;


/* ================================================== Initializers ================================================== */
- (id) initWithQueryId:(NSString*)queryId {
    self = [super init];
    if (self) {
        _queryId = queryId;
        _fields = [[NSMutableArray alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) fields {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [_fields sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void) addField:(expanz_model_FieldSchema*)fieldSchema {
    [_fields addObject:fieldSchema];
}


@end