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


#import <Foundation/Foundation.h>

@class expanz_model_TextGridDataCell;
@class expanz_model_GridData;
@class expanz_model_AbstractGridDataCell;

/**
* Represents a row in an `expanz_model_DataSet`.
*/
@interface expanz_model_Row : NSObject {

@private
    NSMutableDictionary* _cellDefinitions;
    NSMutableArray* _textCells;
    NSMutableArray* _imageCells;
    NSArray* _sortDescriptors;
}

@property(nonatomic, weak) expanz_model_GridData* gridData;
@property(nonatomic, strong, readonly) NSString* rowId;
@property(nonatomic, strong, readonly) NSString* type;

- (id) initWithRowId:(NSString*)rowId type:(NSString*)type;

- (void) addCellDefinitionWithId:(NSString*)cellId data:(NSString*)data;

/**
* Returns the cell with the given id, or nil.
*/
- (expanz_model_AbstractGridDataCell*) cellWithId:(NSString*)cellId;

/**
* Returns the cell matching the given field id, or nil.
*/
- (expanz_model_AbstractGridDataCell*) cellForFieldId:(NSString*)fieldId;

/**
* All `expanz_model_AbstractGridDataCell`s in the Row.
*/
- (NSArray*) cells;

/**
* All of the `expanz_model_TextGridDataCell`s in the Row.
*/
- (NSArray*) textCells;

/**
* All of the `expanz_model_ImageGridDataCell`s in the Row.
*/
- (NSArray*) imageCells;


@end

/* ================================================================================================================== */
@compatibility_alias Row expanz_model_Row;