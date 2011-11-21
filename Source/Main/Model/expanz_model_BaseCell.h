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

/**
* Base class representing a cell in an `expanz_model_Row`.
*/
@interface expanz_model_BaseCell : NSObject

@property(nonatomic, readonly) NSString*(cellId);

- (id) initWithCellId:(NSString*)aCellId;


@end

/* ================================================================================================================== */
@compatibility_alias BaseCell expanz_model_BaseCell;

