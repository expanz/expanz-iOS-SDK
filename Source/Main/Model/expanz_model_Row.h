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

/**
* Represents a row in an `expanz_model_Data`.
*/
@interface expanz_model_Row : NSObject {

@private
    NSMutableArray* _cells;
}

@property (nonatomic, readonly) NSString* rowId;
@property (nonatomic, readonly) NSString* type;

- (id) initWithRowId:(NSString*)rowId type:(NSString*)type;
- (void) addCell:(expanz_model_TextCell*)cell;
- (NSArray*) cells;




@end

/* ================================================================================================================== */
@compatibility_alias Row expanz_model_Row;