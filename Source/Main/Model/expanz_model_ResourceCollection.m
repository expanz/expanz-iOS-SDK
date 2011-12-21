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
#import "expanz_model_ResourceCollection.h"
#import "expanz_model_FileResource.h"


@implementation expanz_model_ResourceCollection

/* ================================================== Initializers ================================================== */
- (id) init {
    self = [super init];
    if (self) {
        _fileResources = [[NSMutableSet alloc] initWithCapacity:4];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) fileResources {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"path" ascending:YES];
    return [_fileResources sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void) addFileResource:(expanz_model_FileResource*)fileResource {
    [_fileResources addObject:fileResource];
}


@end