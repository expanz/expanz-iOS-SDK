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


#import "expanz_model_TextGridDataCell.h"


@implementation expanz_model_TextGridDataCell

@synthesize text = _text;

- (id) initWithCellId:(NSString*)cellId text:(NSString*)text {
    self = [super initWithCellId:cellId];
    if (self) {
        _text = [text copy];
    }
    return self;
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"TextCell: text=%@", _text];
}

@end