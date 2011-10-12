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



@interface expanz_model_ActivityInstance (protected)
@property (nonatomic, readwrite, assign) NSString* title; 
@end

/* ================================================================================================================== */

@implementation expanz_model_ActivityInstance

@synthesize handle = _handle; 
@synthesize persistentId = _persistentId;

/* ================================================== Constructors ================================================== */


- (id) initWithTitle:(NSString*)title handle:(NSString*)handle persistentId:(NSString*)persistentId {
    self = [super initWithName:nil andTitle:title];
    if (self) {
        _handle = [handle retain];
        _persistentId = [persistentId retain];   
    }   
    return self;    
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_handle release];
    [_persistentId release];
    [super dealloc];
}

@end
