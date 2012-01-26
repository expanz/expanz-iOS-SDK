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


#import "expanz_model_Column.h"


@implementation expanz_model_Column

@synthesize dataSet = _dataSet;
@synthesize columnId = _columnId;
@synthesize fieldId = _fieldId;
@synthesize label = _label;
@synthesize dataType = _dataType;
@synthesize width = _width;


/* ================================================== Initializers ================================================== */
- (id) initWithColumnId:(NSString*)columnId field:(NSString*)field label:(NSString*)label
               dataType:(ExpanzDataType)dataType width:(NSInteger)width {

    self = [super init];
    if (self) {
        _columnId = [columnId copy];
        _fieldId = [field copy];
        _label = [label copy];
        _dataType = dataType;
        _width = width;
    }
    return self;
}

@end