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

@class expanz_ui_ModelAdapter;
@class expanz_model_FieldInstance;

@interface UIView (ModelAdapter)

- (NSString*) fieldIdInModelAdapter:(expanz_ui_ModelAdapter*)modelAdapter;

@end