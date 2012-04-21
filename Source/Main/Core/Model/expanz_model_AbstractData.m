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

#import "expanz_model_AbstractData.h"

@implementation expanz_model_AbstractData

@synthesize dataId = _dataId;

/* ================================================== Initializers ================================================== */

- (id) initWithDataId:(NSString*)dataId {
    self = [super init];
    if (self) {
        _dataId = [dataId copy];
    }
    return self;
}

- (int) count {
    @throw([NSException
            exceptionWithName:NSInternalInconsistencyException reason:@"Called abstract method 'count'" userInfo:nil]);
}


@end