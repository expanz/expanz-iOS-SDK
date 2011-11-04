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


#import "expanz_model_Row.h"
#import "expanz_model_TextCell.h"


@implementation expanz_model_Row

@synthesize rowId = _rowId; 
@synthesize type = _type; 

/* ================================================== Constructors ================================================== */
- (id) initWithRowId:(NSString*)rowId type:(NSString*)type {
    self = [super init];
    if (self) {
        _rowId = [rowId copy];
        _type = [type copy];
        _cells = [[NSMutableArray alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */

- (void) addCell:(expanz_model_TextCell*)cell {
    [_cells addObject:cell];
}

- (NSArray*) cells {
    NSSortDescriptor* sorter = [[[NSSortDescriptor alloc] initWithKey:@"cellId" ascending:YES] autorelease];
    return [_cells sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}


/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_rowId release];
    [_type release];
    [_cells release];
    [super dealloc];
}

@end