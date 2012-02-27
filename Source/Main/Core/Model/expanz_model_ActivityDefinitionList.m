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
#import "expanz_model_ActivityDefinitionList.h"


@implementation expanz_model_ActivityDefinitionList


/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _activities = [[NSMutableArray alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) activities {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"title" ascending:YES];
    return [_activities sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void) addActivityDefinition:(expanz_model_ActivityDefinition*)activityDefinition {
    [_activities addObject:activityDefinition];
}


@end