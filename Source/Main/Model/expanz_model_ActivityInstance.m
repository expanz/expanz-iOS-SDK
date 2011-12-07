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

#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_model_GridData.h"
#import "expanz_model_FileResource.h"


@implementation expanz_model_ActivityInstance

@synthesize title = _title;
@synthesize handle = _handle;
@synthesize persistentId = _persistentId;

/* ================================================== Initializers ================================================== */
- (id) initWithTitle:(NSString*)title handle:(NSString*)handle persistentId:(NSString*)persistentId {
    self = [super init];
    if (self) {
        _title = [title copy];
        _handle = [handle copy];
        _persistentId = [persistentId copy];
        _fields = [[NSMutableSet alloc] initWithCapacity:20];
        _messages = [[NSMutableArray alloc] initWithCapacity:10];
        _dataSets = [[NSMutableArray alloc] initWithCapacity:2];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (BOOL) allowsMethodInvocations {
    for (Field* field in _fields) {
        if (field.isDirty) {
            return NO;
        }
    }
    return YES;
}

- (NSArray*) fields {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"fieldId" ascending:YES];
    return [_fields sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void) addField:(Field*)field {
    [field setParentActivity:self];
    [_fields addObject:field];
}

- (Field*) fieldWithId:(NSString*)fieldId {
    for (Field* field in _fields) {
        if ([field.fieldId isEqualToString:fieldId]) {
            return field;
        }
    }
    return nil;
}


- (NSArray*) messages {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"content" ascending:YES];
    return [_messages sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void) addMessage:(expanz_model_Message*)message {
    [_messages addObject:message];
}

- (NSArray*) dataSets {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"dataId" ascending:YES];
    return [_dataSets sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void) addData:(expanz_model_AbstractData*)data {
    [_dataSets addObject:data];
}

- (expanz_model_AbstractData*) dataWithId:(NSString*)dataSetId {
    for (GridData* dataSet in _dataSets) {
        if ([dataSet.dataId isEqualToString:dataSetId]) {
            return dataSet;
        }
    }
    return nil;
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Activity Instance: title=%@, handle=%@, persistentId=%@", _title, _handle,
                                      _persistentId];
}

- (void) dealloc {
    [_handle release];
    [_persistentId release];
    [_fields release];
    [_messages release];
    [_dataSets release];
    [super dealloc];
}

@end
