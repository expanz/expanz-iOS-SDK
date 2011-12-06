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
#import "expanz_service_ActivityClientDelegate.h"

@class expanz_model_ActivityDefinition;
@class expanz_model_Field;
@class expanz_ui_ModelAdapter;
@class expanz_service_CreateActivityRequest;
@class expanz_ui_components_ThumbnailTableCell;
@class expanz_ui_NavigationManager;


@interface expanz_ui_ActivityInstanceViewController : UIViewController <expanz_service_ActivityClientDelegate,
    UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {

@private
    id<expanz_service_ActivityClient> _activityClient;
    expanz_service_CreateActivityRequest* _activityRequest;
    expanz_ui_NavigationManager* _activityManager;
    UITextField* _currentlyEditingField;
    UIImageView* _currentlyEditingImageView;
}

@property(nonatomic, readonly) expanz_model_ActivityDefinition* activityDefinition;
@property(nonatomic, readonly) expanz_model_ActivityInstance* activityInstance;
@property(nonatomic, readonly) expanz_ui_ModelAdapter* modelAdapter;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView* spinner;


/**
 * Initialize a new activity instance view controller with the supplied activity and record identifier key.  
 */
- (id)initWithActivityDefinition:(expanz_model_ActivityDefinition*)activityDefinition nibName:(NSString*)nibName
                      initialKey:(NSString*)initialKey;

/**
 * Request model to update with new field value. 
 */
- (void)sendDeltaForField:(expanz_model_Field*)textField;

/**
 * Invoke a method on the model. 
 */
- (void)sendMethodInvocation:(NSString*)methodName;

- (void)hasUITableView:(UITableView*)tableView requestingDataPublicationId:(NSString*)dataPublicationId;

- (void)hasUITableView:(UITableView*)tableView requestingPopulateMethod:(NSString*)populateMethod;

- (void)hasUITableView:(UITableView*)tableView requestingQuery:(NSString*)query;

- (void)hasUITableView:(UITableView*)tableView requestingAutoPopulate:(BOOL)autoPopulate;

- (void)willCommenceEditForImageView:(UIButton*)sender;


@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstanceViewController expanz_ui_ActivityInstanceViewController;