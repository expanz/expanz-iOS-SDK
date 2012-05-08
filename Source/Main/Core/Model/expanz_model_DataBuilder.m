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
#import "expanz_model_DataBuilder.h"
#import "expanz_model_AbstractData.h"
#import "expanz_model_Row.h"
#import "expanz_model_Column.h"
#import "expanz_model_Folder.h"
#import "expanz_model_GridData.h"
#import "expanz_model_TreeData.h"

@implementation expanz_model_DataBuilder

@synthesize source = _source;
@synthesize query = _query;
@synthesize contextObject = _contextObject;

/* ================================================== Initializers ================================================== */
- (id)initWithDataId:(NSString*)dataId {
    self = [super init];
    if (self) {
        _dataId = [dataId copy];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (expanz_model_AbstractData*)build {
    if (_data == nil) {
        LogDebug(@"**** Warning **** data with id %@ has no data, returning nil", _dataId);
    }
    return _data;
}

- (void)addRow:(expanz_model_Row*)row {
    if (_data == nil) {
        _data = [[GridData alloc] initWithDataId:_dataId source:_source query:_query contextObject:_contextObject];
    }
    else if ([_data class] == [TreeData class]) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Can't add both GridData and TreeData attributes to the same instance."];
    }
    GridData* gridData = (GridData*) _data;
    [gridData addRow:row];
}

- (void)addColumn:(expanz_model_Column*)column {
    if (_data == nil) {
        _data = [[GridData alloc] initWithDataId:_dataId source:_source query:_query contextObject:_contextObject];
    }
    else if ([_data class] == [TreeData class]) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Can't add both GridData and TreeData attributes to the same instance."];
    }
    GridData* gridData = (GridData*) _data;
    [gridData addColumn:column];
}

- (void)addFolder:(expanz_model_Folder*)folder {
    if (_data == nil) {
        _data = [[TreeData alloc] initWithDataId:_dataId];
    }
    else if ([_data class] == [GridData class]) {
        [NSException raise:NSInvalidArgumentException
                    format:@"Can't add both GridData and TreeData attributes to the same instance."];
    }
    TreeData* treeData = (TreeData*) _data;
    [treeData addFolder:folder];
}


@end