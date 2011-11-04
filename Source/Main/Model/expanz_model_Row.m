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
#import "expanz_model_Column.h"
#import "expanz_model_DataSet.h"
#import "expanz_model_TextCell.h"
#import "expanz_model_ImageCell.h"


@implementation expanz_model_Row

@synthesize dataSet = _dataSet;
@synthesize rowId = _rowId;
@synthesize type = _type;

/* ================================================== Constructors ================================================== */
- (id) initWithRowId:(NSString*)rowId type:(NSString*)type {
    self = [super init];
    if (self) {
        _rowId = [rowId copy];
        _type = [type copy];
        _cellDefinitions = [[NSMutableDictionary alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) addCellWithId:(NSString*)cellId data:(NSString*)data {
    [_cellDefinitions setValue:data forKey:cellId];
}


- (NSArray*) cells {
    if (_cells == nil) {
        _cells = [[NSMutableArray alloc] initWithCapacity:[_cellDefinitions count]];
        for (NSString* cellId in [_cellDefinitions allKeys]) {
            Column* column = [_dataSet columnWithId:cellId];
            if (column == nil) {
                [NSException raise:NSInternalInconsistencyException format:@"No column for cell with id: %@", cellId];
            }

            NSString* data = [_cellDefinitions valueForKey:cellId];
            switch (column.dataType) {
                case ExpanzDataTypeString:
                case ExpanzDataTypeNumber:
                    [_cells addObject:[[[TextCell alloc] initWithCellId:cellId text:data] autorelease]];
                    break;
                case ExpanzDataTypeImage:
                    LogDebug("Adding image cell");
                    [_cells addObject:[[[ImageCell alloc] initWithCellId:cellId imageUrl:data] autorelease]];
                    break;
            }
        }
    }
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"cellId" ascending:YES];
    return [_cells sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}


/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_rowId release];
    [_type release];
    [_cellDefinitions release];
    [super dealloc];
}

@end