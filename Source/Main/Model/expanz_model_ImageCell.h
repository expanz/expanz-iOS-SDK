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
#import "expanz_model_AbstractCell.h"

@class expanz_ui_ModelAdapter;

/**
* Represents an image in an `expanz_model_Row` of a data grid. The image is fetched asynchronously, so that the table
* rows can be presented as quickly as possible.
*/
@interface expanz_model_ImageCell : expanz_model_AbstractCell

@property(nonatomic, strong, readonly) NSString* imageUrl;
@property(nonatomic, retain) UIImage* image;
@property(nonatomic) BOOL hasAskedImageToLoad;


- (id) initWithCellId:(NSString*)cellId imageUrl:(NSString*)imageUrl;
- (void) loadImage;

@end

/* ================================================================================================================== */
@compatibility_alias ImageCell expanz_model_ImageCell;