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
#import "expanz_model_FileResource.h"


@implementation expanz_model_FileResource

@synthesize path = _path; 
@synthesize ext = _ext; 
@synthesize field = _field; 

/* ================================================== Initializers ================================================== */
- (id) initWithPath:(NSString*)path ext:(NSString*)ext field:(NSString*)field {
    self = [super init];
    if (self) {
        _path = [path copy];
        _ext = [ext copy];
        _field = [field copy];
    }
    return self;
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"FileResource: path='%@', ext='%@', field='%@'", _path, _ext, _field];
}


@end