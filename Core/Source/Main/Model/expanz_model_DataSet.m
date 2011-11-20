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


#import "expanz_model_DataSet.h"
#import "expanz_model_Column.h"
#import "expanz_model_Row.h"


@implementation expanz_model_DataSet

@synthesize dataId = _dataId;
@synthesize source = _source;

/* ================================================== Constructors ================================================== */
- (id) initWithDataId:(NSString*)dataId source:(NSString*)source {
    self = [self init];
    if (self) {
        _dataId = [dataId copy];
        _source = [source copy];
        _columns = [[NSMutableArray alloc] init];
        _rows = [[NSMutableArray alloc] init];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
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

- (void) addRow:(Row*)row {
    row.dataSet = self;
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


/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_dataId release];
    [_source release];
    [_columns release];
    [_rows release];
}

@end