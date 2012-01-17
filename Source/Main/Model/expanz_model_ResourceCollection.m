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

@synthesize title = _title;

/* ================================================== Initializers ================================================== */
- (id) initWithTitle:(NSString*)title {
    self = [super init];
    if (self) {
        _title = [title copy];
        _fileResources = [[NSMutableSet alloc] initWithCapacity:4];
    }
    return self;
}

- (id) init {
    return [self initWithTitle:nil];
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) fileResources {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"path" ascending:YES];
    return [_fileResources sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void) addFileResource:(expanz_model_FileResource*)fileResource {
    [_fileResources addObject:fileResource];
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"ResourceCollection: title=%@, fileResources: %@", _title, _fileResources];
}

@end