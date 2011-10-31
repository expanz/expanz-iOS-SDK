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

@class expanz_model_Column;
@class expanz_model_Row;

/**
* Top level container for holding repeating records of information in an `expanz_model_ActivityInstance`.
*/
@interface expanz_model_Data : NSObject {

@private
    NSMutableArray* _columns;
    NSMutableArray* _rows;

}

@property (nonatomic, readonly) NSString* dataId;
@property (nonatomic, readonly) NSString* source;

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
- (void) columnWithId:(NSString*)columnId;

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
@compatibility_alias Data expanz_model_Data;