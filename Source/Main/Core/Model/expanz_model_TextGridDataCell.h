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
#import "expanz_model_AbstractGridDataCell.h"

/**
* Represents a cell belonging to an `expanz_model_Row`.
*/
@interface expanz_model_TextGridDataCell : expanz_model_AbstractGridDataCell

@property (nonatomic, strong, readonly) NSString* text;

- (id) initWithCellId:(NSString*)cellId text:(NSString*)text;

@end

/* ================================================================================================================== */
@compatibility_alias TextGridDataCell expanz_model_TextGridDataCell;