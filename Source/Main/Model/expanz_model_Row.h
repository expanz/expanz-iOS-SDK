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

@class expanz_model_TextCell;
@class expanz_model_DataSet;

/**
* Represents a row in an `expanz_model_DataSet`.
*/
@interface expanz_model_Row : NSObject {

@private
    NSMutableDictionary* _cellDefinitions;
    NSMutableArray* _cells;
}

@property (nonatomic, assign) expanz_model_DataSet* dataSet;
@property (nonatomic, readonly) NSString* rowId;
@property (nonatomic, readonly) NSString* type;

- (id) initWithRowId:(NSString*)rowId type:(NSString*)type;
- (void) addCellWithId:(NSString*)cellId data:(NSString*)data;
- (NSArray*) cells;




@end

/* ================================================================================================================== */
@compatibility_alias Row expanz_model_Row;