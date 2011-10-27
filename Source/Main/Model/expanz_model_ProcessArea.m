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

#import "expanz_model_ProcessArea.h"
#import "expanz_model_ActivityDefinition.h"

@implementation expanz_model_ProcessArea

@synthesize processId = _processId;
@synthesize title = _title;

/* ================================================== Constructors ================================================== */
- (id) initWithProcessId:(NSString*)processId andTitle:(NSString*)title {
    self = [self init];     
    if (self) {
        _processId = [processId retain];
        _title = [title retain];
        _activities = [[NSMutableSet alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) activities {
    NSSortDescriptor* sorter = [[[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES] autorelease];
    return [_activities sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]]; 
}

- (void) addActivityDefinition:(ActivityDefinition*)activity {
    [_activities addObject:activity];    
}

- (ActivityDefinition*) activityWithName:(NSString*)activityName {
    for (ActivityDefinition* activity in _activities) {
        if ([activity.name isEqualToString:activityName]) {
            return activity;
        }
    }
    return nil;
}


/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"ProcessArea: id=%@, title=%@, activities: %@", _processId, _title, _activities];
}

- (void) dealloc {
    [_processId release];
    [_title release];
    [super dealloc];
}

@end
