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

#import "expanz_model_UserRole.h"

@implementation expanz_model_UserRole

@synthesize roleId = _roleId;
@synthesize description = _description;

/* ================================================== Constructors ================================================== */

- (id)init {
    self = [super init];    
    if (!self) {
        [NSException raise:@"Initialization failed." format:@"Call to superclass initializer failed."];
    }
    return self;
}

- (id) initWithRoleId:(NSString*)roleId andDescription:(NSString*)description {
    self = [self init]; 
    _roleId = [roleId retain]; 
    _description = [description retain];
    return self;
}

/* ================================================== Utility Methods =============================================== */

- (NSString*) description {
    return [NSString stringWithFormat:@"UserRole: roleId=%@, description=%@", _roleId, _description];
}

- (void) dealloc {
    [_roleId release];
    [_description release];
    [super dealloc];
}

@end
