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
#import "expanz_model_GridData.h"
#import "expanz_model_TextGridDataCell.h"
#import "expanz_model_ImageGridDataCell.h"

/* ================================================================================================================== */
@interface expanz_model_Row (private)

- (void) buildCellsIfRequired;

@end

/* ================================================================================================================== */
@implementation expanz_model_Row

@synthesize gridData = _gridData;
@synthesize rowId = _rowId;
@synthesize type = _type;

/* ================================================== Initializers ================================================== */
- (id) initWithRowId:(NSString*)rowId type:(NSString*)type {
    self = [super init];
    if (self) {
        _rowId = [rowId copy];
        _type = [type copy];
        _cellDefinitions = [[NSMutableDictionary alloc] init];
        NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"cellId" ascending:YES];
        _sortDescriptors = [[NSArray alloc] initWithObjects:sorter, nil];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) addCellDefinitionWithId:(NSString*)cellId data:(NSString*)data {
    [_cellDefinitions setValue:data forKey:cellId];
}

- (AbstractGridDataCell*) cellWithId:(NSString*)cellId {
    for (AbstractGridDataCell* cell in [self cells]) {
        if ([cell.cellId isEqualToString:cellId]) {
            return cell;
        }
    }
    return nil;
}

 - (expanz_model_AbstractGridDataCell*) cellForFieldId:(NSString*)fieldId {
     Column* column = [_gridData columnWithFieldId:fieldId];
     if (column != nil) {
         return [self cellWithId:column.columnId];
     }
     return nil;
 }


 - (NSArray*) cells {
    NSArray* allCells = [[self textCells] arrayByAddingObjectsFromArray:[self imageCells]];
    return [allCells sortedArrayUsingDescriptors:_sortDescriptors];
}

- (NSArray*) textCells {
    [self buildCellsIfRequired];
    return [_textCells sortedArrayUsingDescriptors:_sortDescriptors];

}

- (NSArray*) imageCells {
    [self buildCellsIfRequired];
    return [_imageCells sortedArrayUsingDescriptors:_sortDescriptors];
}

 /* ================================================== Utility Methods =============================================== */
 - (NSString*) description {
     return [NSString stringWithFormat:@"Row: cells = %@", [self cells]];
 }

/* ================================================== Private Methods =============================================== */
- (void) buildCellsIfRequired {

    if (_textCells == nil || _imageCells == nil) {
        _textCells = [[NSMutableArray alloc] init];
        _imageCells = [[NSMutableArray alloc] init];

        for (NSString* cellId in [_cellDefinitions allKeys]) {
            Column* column = [_gridData columnWithId:cellId];
            if (column == nil) {
                [NSException raise:NSInternalInconsistencyException format:@"No column for cell with id: %@", cellId];
            }

            NSString* data = [_cellDefinitions valueForKey:cellId];
            switch (column.dataType) {
                case ExpanzDataTypeString:
                case ExpanzDataTypeNumber:
                case ExpanzDataTypeDate:
                case ExpanzDataTypeDateTime:
                    [_textCells addObject:[[TextGridDataCell alloc] initWithCellId:cellId text:data]];
                    break;
                case ExpanzDataTypeImage:
                    [_imageCells addObject:[[ImageGridDataCell alloc] initWithCellId:cellId imageUrl:data]];
                    break;
                case ExpanzDataTypeBool:
                    //TODO: Handle this!
                    break;
                case ExpanzDataTypeNull:
                    break;
            }
        }
    }
}


@end