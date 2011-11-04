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
#import "expanz_model_BaseCell.h"

/**
* Represents a cell belonging to an `expanz_model_Row`.
*/
@interface expanz_model_TextCell : expanz_model_BaseCell

@property (nonatomic, readonly) NSString* data;

- (id) initWithCellId:(NSString*)cellId data:(NSString*)data;

@end

/* ================================================================================================================== */
@compatibility_alias TextCell expanz_model_TextCell;