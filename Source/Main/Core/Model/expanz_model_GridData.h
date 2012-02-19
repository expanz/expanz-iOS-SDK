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
#import "expanz_model_AbstractData.h"

@class expanz_model_Column;
@class expanz_model_Row;


/**
* Repeating data arranged as columns and rows.
*/
@interface expanz_model_GridData : expanz_model_AbstractData {

@private
    NSMutableArray* _columns;
    NSMutableArray* _rows;

}

@property (nonatomic, strong, readonly) NSString* source;
@property (nonatomic, strong, readonly) NSArray* rows; 
@property (nonatomic, strong, readonly) NSArray* columns; 

/**
* Initializes an instance with the supplied id and source attributes.
*/
- (id) initWithDataId:(NSString*)dataId source:(NSString*)source;

/**
* Adds a column to the data set.
*/
- (void) addColumn:(expanz_model_Column*)column;

/**
* Returns a copy of the data set's columns.
*/
- (NSArray*) columns;

/**
* Returns the column with the supplied id parameter or nil.
*/
- (expanz_model_Column*) columnWithId:(NSString*)columnId;

/**
* Returns the column with the supplied field id parameter or nil.
*/
- (expanz_model_Column*) columnWithFieldId:(NSString*)fieldId;

/**
* Adds a row to the data set.
*/
- (void) addRow:(expanz_model_Row*)row;

/**
* Returns a copy of the data set's rows.
*/
- (NSArray*) rows;

/**
* Returns the row with the supplied row id, or nil.
*/
- (expanz_model_Row*) rowWithId:(NSString*)rowId;

@end

/* ================================================================================================================== */
@compatibility_alias GridData expanz_model_GridData;