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
@class expanz_model_DataSet;

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
 * Returns the UITextField corresponding to the model's field object.
 */
- (UITextField*) textInputControlFor:(expanz_model_Field*)field;

/** 
 * Returns the `expanz_model_Field` object corresponding to the UITextField object.
 */
- (expanz_model_Field*) fieldFor:(UITextField*)textControl;

/**
* Returns the `expanz_model_DataSet` object backing the UITableView component.
*/
- (UITableView*) dataViewControlFor:(expanz_model_DataSet*)dataSet;

- (expanz_model_DataSet*) dataSetFor:(UITableView*)dataControl;

/**
 * Updates UI text fields and labels with values from the model object. 
 */
- (void) updateUIControlsWithModelValues; 


@end

/* ================================================================================================================== */
@compatibility_alias ModelAdapter expanz_ui_ModelAdapter;