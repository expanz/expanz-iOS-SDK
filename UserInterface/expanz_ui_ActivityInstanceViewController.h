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

#import <UIKit/UIKit.h>
#import "expanz_service_ActivityClient.h"
@class expanz_model_Activity;
@class expanz_model_Field;
@class expanz_ui_ModelAdapter;


@interface expanz_ui_ActivityInstanceViewController : 
    UIViewController<expanz_service_ActivityClientDelegate, UITextFieldDelegate> {
    
@private        
    expanz_ui_ModelAdapter* _modelAdapter;
    UITextField* _currentlyEditingField;    
        
}

@property (nonatomic, readonly) expanz_model_ActivityInstance* activityInstance;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* spinner;

/**
 * Initialize a new activity instance view controller with the supplied activity. 
 */
-(id) initWithActivity:(expanz_model_Activity*)activity; 

/**
 * Request model to update with new field value. 
 */
- (void) sendDeltaForField:(UITextField*)textField;

/**
 * Invoke a method on the model. 
 */
- (void) sendMethodInvocation:(NSString*)methodName;

/** 
 * Returns activity client service. 
 */
- (id<expanz_service_ActivityClient>) activityClient;

/**
 * Enables or disables expanz editable controls. 
 */
- (void) setFieldsEnabled:(BOOL)enabled;

/**
 * Hides or shows expanz editable controls. 
 */
- (void) setFieldsHidden:(BOOL)hidden;

@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstanceViewController expanz_ui_ActivityInstanceViewController;