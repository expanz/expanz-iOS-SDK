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
@class expanz_model_ActivityDefinition;
@class expanz_model_Field;
@class expanz_ui_ModelAdapter;
@class expanz_service_CreateActivityRequest;


@interface expanz_ui_ActivityInstanceViewController : 
    UIViewController<expanz_service_ActivityClientDelegate, UITextFieldDelegate> {
    
@private
    expanz_service_CreateActivityRequest* _activityRequest;
    UITextField* _currentlyEditingField;
}

@property (nonatomic, readonly) expanz_ui_ModelAdapter* modelAdapter;
@property (nonatomic, retain) expanz_model_ActivityInstance* activityInstance;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* spinner;

/**
 * Initialize a new activity instance view controller with the supplied activity. 
 */
-(id) initWithActivity:(expanz_model_ActivityDefinition *)activity;

/**
 * Request model to update with new field value. 
 */
- (void) sendDeltaForField:(expanz_model_Field*)textField;

/**
 * Invoke a method on the model. 
 */
- (void) sendMethodInvocation:(NSString*)methodName;

/** 
 * Returns activity client service. 
 */
- (id<expanz_service_ActivityClient>) activityClient;

- (void) hasUITableView:(UITableView*)tableView requestingDataPublicationId:(NSString*)dataPublicationId;
- (void) hasUITableView:(UITableView*)tableView requestingPopulateMethod:(NSString*)populateMethod;
- (void) hasUITableView:(UITableView*)tableView requestingAutoPopulate:(BOOL)autoPopulate;


@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstanceViewController expanz_ui_ActivityInstanceViewController;