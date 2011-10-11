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

- (id) init {
    self = [super init];    
    if (!self) {
        [NSException raise:ExObjectInitializationException format:@"Call to super-class initialization failed."];
    }
    return self;
}

- (id) initWithTitle:(NSString*)title handle:(NSString*)handle persistentId:(NSString*)persistentId {
    self = [self init];
    _handle = [handle retain];
    _persistentId = [persistentId retain];    
    return self;    
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_handle release];
    [_persistentId release];
    [super dealloc];
}

@end
