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
#import "expanz_model_BaseData.h"


@implementation expanz_model_BaseData

@synthesize dataId = _dataId;

/* ================================================== Constructors ================================================== */

- (id)initWithDataId:(NSString*)dataId {
    self = [super init];
    if (self) {
        _dataId = [dataId copy];
    }
    return self;
}



/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_dataId release];
    [super dealloc];
}

@end