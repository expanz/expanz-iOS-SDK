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


#import "expanz_model_TextCell.h"


@implementation expanz_model_TextCell

@synthesize cellId = _cellId; 
@synthesize data = _data;

- (id) initWithCellId:(NSString*)cellId data:(NSString*)data {
    self = [super init];
    if (self) {
        _cellId = [cellId retain];
        _data = [data retain];
    }
    return self;
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_cellId release];
    [_data release];
    [super dealloc];
}

@end