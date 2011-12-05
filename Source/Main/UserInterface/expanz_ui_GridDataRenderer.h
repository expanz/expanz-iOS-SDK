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
#import "expanz_ui_AbstractDataRenderer.h"


@class expanz_ui_ActivityManager;
@class expanz_ui_components_ThumbnailTableCell;
@class expanz_model_GridData;

@interface expanz_ui_GridDataRenderer : expanz_ui_AbstractDataRenderer {

@private
    expanz_model_GridData* _gridData;
}

/**
* Injection point for loading custom table cells from a nib.
*/
@property(nonatomic, assign) IBOutlet expanz_ui_components_ThumbnailTableCell* tableCell;


@end

/* ================================================================================================================== */
@compatibility_alias GridDataRenderer expanz_ui_GridDataRenderer;