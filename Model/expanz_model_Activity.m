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

#import "expanz_model_Activity.h"

@implementation expanz_model_Activity

@synthesize name = _name;
@synthesize title = _title;

/* ================================================== Constructors ================================================== */

- (id) initWithName:(NSString*)name andTitle:(NSString*)title {
    self = [self init];     
    if (!self) {
        [NSException raise:@"Initialization failed." format:@"Call to superclass initializer failed."];
    }
    _name = [name retain]; 
    _title = [title retain];
    return self; 
}

/* ================================================== Utility Methods =============================================== */

- (NSString*) description {
    return [NSString stringWithFormat:@"Activity name=%@, title=%@", _name, _title];
}

- (void) dealloc {
    [_name release];
    [_title release];
    [super dealloc];
}



@end
