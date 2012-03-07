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
#import "expanz_model_FieldSchema.h"
#import "expanz_model_ActivityStyle.h"
#import "expanz_model_Query.h"


@implementation expanz_model_ActivitySchema
@synthesize activityId = _activityId;
@synthesize title = _title;

/* ================================================== Initializers ================================================== */
- (id) initWithActivityId:(NSString*)activityId title:(NSString*)title {
    self = [super init];
    if (self) {
        _activityId = [activityId copy];
        _title = [title copy];
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
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    return [_styles sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (NSArray*) queries {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"queryId" ascending:YES];
    return [_queries sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void) addField:(expanz_model_FieldInstance*)field {
    [_fields addObject:field];
}

- (void) addMethod:(expanz_model_MethodSchema*)method {
    [_methods addObject:method];
}

- (void) addStyle:(expanz_model_ActivityStyle*)style {
    [_styles addObject:style];
}

- (void) addQuery:(expanz_model_Query*)query {
    [_queries addObject:query];
}


/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"ActivitySchema: fields=%@, methods=%@, styles=%@, queries=%@", _fields,
                                      _methods, _styles, _queries];
}


@end