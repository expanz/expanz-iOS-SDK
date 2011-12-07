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


#import "expanz_model_AbstractCell.h"


@implementation expanz_model_AbstractCell

@synthesize cellId = _cellId;

/* ================================================== Initializers ================================================== */
- (id) initWithCellId:(NSString*)cellId {
    self = [super init];
    if (self) {
        _cellId = [cellId copy];
    }
    return self;

}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_cellId release];
    [super dealloc];
}


@end