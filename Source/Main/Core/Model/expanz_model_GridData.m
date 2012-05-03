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


#import "expanz_model_GridData.h"
#import "expanz_model_Column.h"
#import "expanz_model_Row.h"

@implementation expanz_model_GridData

@synthesize source = _source;

/* ================================================== Initializers ================================================== */
- (id) initWithDataId:(NSString*)dataId source:(NSString*)source {
    self = [super initWithDataId:dataId];
    if (self) {
        _source = [source copy];
        _columns = [[NSMutableArray alloc] init];
        _rows = [[NSMutableArray alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*) fieldIdentifiers {
    NSMutableArray* allFieldNames = [NSMutableArray array];
    for (Column* column in _columns) {
        [allFieldNames addObject:column.fieldId];
    }
    return [NSArray arrayWithArray:allFieldNames];
}


- (void) addColumn:(Column*)column {
    column.dataSet = self;
    [_columns addObject:column];
}

- (NSArray*) columns {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"columnId" ascending:YES];
    return [_columns sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (Column*) columnWithId:(NSString*)columnId {
    for (Column* column in _columns) {
        if ([column.columnId isEqualToString:columnId]) {
            return column;
        }
    }
    return nil;
}

- (Column*) columnWithFieldId:(NSString*)fieldId {
    for (Column* column in _columns) {
        if ([column.fieldId isEqualToString:fieldId]) {
            return column;
        }
    }
    return nil;
}

- (void) addRow:(Row*)row {
    [row setGridData:self];
    [_rows addObject:row];
}

- (NSArray*) rows {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"rowId" ascending:YES];
    return [_rows sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (expanz_model_Row*) rowWithId:(NSString*)rowId {
    for (Row* row in _rows) {
        if ([row.rowId isEqualToString:rowId]) {
            return row;
        }
    }
    return nil;
}

/* ================================================================================================================== */
#pragma mark AbstractData Template Methods

- (int) count {
    return [_rows count];
}

/* ================================================== Utility Methods =============================================== */
- (NSString*) description {
    return [NSString stringWithFormat:@"GridData id=%@", self.dataId];
}

@end