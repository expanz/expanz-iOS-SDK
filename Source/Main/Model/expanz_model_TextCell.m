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
@synthesize text = _text;

- (id) initWithCellId:(NSString*)cellId text:(NSString*)text {
    self = [super init];
    if (self) {
        _cellId = [cellId copy];
        _text = [text copy];
    }

    return self;

}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_text release];
    [_cellId release];
    [super dealloc];
}

@end