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
    }   
    return self;    
}

/* ================================================ Interface Methods =============================================== */

- (NSArray*) fields {
    NSSortDescriptor* sorter = [[[NSSortDescriptor alloc] initWithKey:@"fieldId" ascending:YES] autorelease];
    return [_fields sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]]; 
}

- (void) addField:(Field*)field {
    [_fields addObject:field]; 
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
