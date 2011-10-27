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
#import "expanz_iOS_SDKExceptions.h"
#import "expanz_model_Field.h"


@implementation expanz_model_ActivityInstance

@synthesize handle = _handle; 
@synthesize persistentId = _persistentId;

/* ================================================== Constructors ================================================== */
- (id) initWithTitle:(NSString*)title handle:(NSString*)handle persistentId:(NSString*)persistentId {
    self = [super initWithName:nil andTitle:title];
    if (self) {
        _handle = [handle retain];
        _persistentId = [persistentId retain];   
        _fields = [[NSMutableSet alloc] initWithCapacity:20];
        _messages = [[NSMutableArray alloc] initWithCapacity:10];
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
    NSSortDescriptor* sorter = [[[NSSortDescriptor alloc] initWithKey:@"fieldId" ascending:YES] autorelease];
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
    NSSortDescriptor* sorter = [[[NSSortDescriptor alloc] initWithKey:@"content" ascending:YES] autorelease];
    return [_messages sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];             
}

- (void) addMessage:(expanz_model_Message*)message {
    [_messages addObject:message];
}


/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"Activity Instance: title=%@, handle=%@, persistentId=%@", super.title, 
            _handle, _persistentId]; 
}

- (void) dealloc {
    [_handle release];
    [_persistentId release];
    [super dealloc];
}

@end
