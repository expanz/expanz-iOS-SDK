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
@class expanz_model_ActivityInstance;
@class expanz_model_Field;
@class expanz_ui_ActivityInstanceViewController;

@interface expanz_ui_ModelAdapter : NSObject {
    
@private    
    NSMutableDictionary* _fieldMappings;
    NSMutableDictionary* _labelMappings; 
    
}

@property (nonatomic, readonly) expanz_model_ActivityInstance* activityInstance; 

/**
 * Initializes a model adapter for the given view controller. 
 */
- (id) initWithViewController:(expanz_ui_ActivityInstanceViewController*)viewController;

/**
 * Returns the UIText field corresponding to the model's field object. 
 */
- (UITextField*) textInputControlFor:(expanz_model_Field*)field;

/** 
 * Returns the field object corresponding to the UITextField object. 
 */
- (expanz_model_Field*) fieldFor:(UITextField*)control;


- (UITableView*) dataViewControlFor:(id)data;

/**
 * Updates UI text fields and labels with values from the model object. 
 */
- (void) updateUIControlsWithModelValues; 


@end

/* ================================================================================================================== */
@compatibility_alias ModelAdapter expanz_ui_ModelAdapter;