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


@class expanz_ui_NavigationManager;
@class expanz_ui_components_ThumbnailTableCell;
@class expanz_model_GridData;

@interface expanz_ui_GridDataRenderer : expanz_ui_AbstractDataRenderer {

@private
    NSMutableArray* _observedCells;
    expanz_model_GridData* _gridData;
    BOOL _shouldStoreFieldIdentifiersToRender;
}

@property(nonatomic, strong, readonly) NSString* mainLabelFieldId;
@property(nonatomic, strong, readonly) NSString* subLabelFieldId;
@property(nonatomic, strong, readonly) NSString* thumbnailFieldId;


@end

/* ================================================================================================================== */
@compatibility_alias GridDataRenderer expanz_ui_GridDataRenderer;