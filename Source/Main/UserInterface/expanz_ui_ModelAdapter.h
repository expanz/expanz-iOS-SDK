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
@class expanz_model_GridData;
@class expanz_model_AbstractCell;
@class expanz_model_ImageCell;
@class expanz_model_AbstractData;

@interface expanz_ui_ModelAdapter : NSObject {

@private
    NSMutableArray* _propertyNames;
    NSMutableDictionary* _textFieldMappings;
    NSMutableDictionary* _imageFieldMappings;
    NSMutableDictionary* _labelMappings;
    NSMutableDictionary* _dataSetMappings;
    NSMutableDictionary* _imageButtonMappings;

}

@property(nonatomic, readonly) NSString* activityName;
@property(nonatomic, readonly) expanz_model_ActivityInstance* activityInstance;

/**
* Initializes a model adapter for the given view controller.
*/
- (id) initWithViewController:(expanz_ui_ActivityInstanceViewController*)viewController;

/* ================================================================================================================== */
#pragma mark Mapping of Controls
/**
 * Returns the UITextField corresponding to the model's field object.
 */
- (UITextField*) textInputControlFor:(expanz_model_Field*)field;

/** 
 * Returns the `expanz_model_Field` object corresponding to the UITextField object.
 */
- (expanz_model_Field*) fieldFor:(UIView*)uiControl;

/**
* Returns the UITableView corresponding to the supplied `expanz_model_DataSet`.
*/
- (UITableView*) dataViewControlFor:(expanz_model_GridData*)dataSet;

/**
* Returns the UIImageView underneath the touch area that allows editing the image.
*/
- (UIImageView*) imageViewFor:(UIButton*)editButton;

/* ================================================================================================================== */
#pragma mark Synchronizing control values with model values.
/**
 * Updates all UI controls with values from the model object.
 */
- (void) updateUIControlsWithModelValues;

/**
* Update UILabels with values from the model object.
*/
- (void) updateLabelsWithModelValues;

/**
* Updates UITextFields with values from the model object.
*/
- (void) updateUITextFieldsWithModelValues;

/**
* Updates UIImageViews with values from the model object.
*/
- (void) updateUIImagesWithModelValues;

/**
* Update data grids with values from the model object.
*/
- (void) updateDataGridsWithModelValues;



@end

/* ================================================================================================================== */
@compatibility_alias ModelAdapter expanz_ui_ModelAdapter;