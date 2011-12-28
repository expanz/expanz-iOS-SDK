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
#import "expanz_ui_AbstractDataRenderer.h"
#import "expanz_ui_GridDataRenderer.h"


@implementation expanz_model_GridData

@synthesize source = _source;

/* ================================================== Initializers ================================================== */
- (id)initWithDataId:(NSString*)dataId source:(NSString*)source {
    self = [super initWithDataId:dataId];
    if (self) {
        _source = [source copy];
        _columns = [[NSMutableArray alloc] init];
        _rows = [[NSMutableArray alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void)addColumn:(Column*)column {
    column.dataSet = self;
    [_columns addObject:column];
}

- (NSArray*)columns {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"columnId" ascending:YES];
    return [_columns sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (Column*)columnWithId:(NSString*)columnId {
    for (Column* column in _columns) {
        if ([column.columnId isEqualToString:columnId]) {
            return column;
        }
    }
    return nil;
}

- (void)addRow:(Row*)row {
    [row setGridData:self];
    [_rows addObject:row];
}

- (NSArray*)rows {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"rowId" ascending:YES];
    return [_rows sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (expanz_model_Row*)rowWithId:(NSString*)rowId {
    for (Row* row in _rows) {
        if ([row.rowId isEqualToString:rowId]) {
            return row;
        }
    }
    return nil;
}

/* ================================================= Protocol Methods =============================================== */
- (expanz_ui_AbstractDataRenderer*)withDataRendererFor:(UITableView*)tableView activityName:(NSString*)activityName {
    return [[GridDataRenderer alloc] initWithData:self tableView:tableView activityName:activityName];
}


@end