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
#import "ExpanzDataType.h"

@class expanz_model_DataSet;


/**
* Represents a column in an `expanz_model_DataSet`.
*/
@interface expanz_model_Column : NSObject {

@private
    expanz_model_DataSet* _dataSet;

}

@property(nonatomic, assign) expanz_model_DataSet* dataSet;
@property(nonatomic, readonly) NSString* columnId;
@property(nonatomic, readonly) NSString* field;
@property(nonatomic, readonly) NSString* label;
@property(nonatomic, readonly) ExpanzDataType dataType;
@property(nonatomic, readonly) NSInteger width;

- (id) initWithColumnId:(NSString*)columnId field:(NSString*)field label:(NSString*)label
               dataType:(ExpanzDataType)dataType width:(NSInteger)width;


@end

/* ================================================================================================================== */
@compatibility_alias Column expanz_model_Column;