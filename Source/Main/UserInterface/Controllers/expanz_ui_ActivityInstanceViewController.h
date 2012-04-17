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
#import "MBProgressHUD.h"

@class expanz_model_ActivityMenuItem;
@class expanz_model_FieldInstance;
@class expanz_ui_ModelAdapter;
@class expanz_service_CreateActivityRequest;
@class expanz_ui_components_ThumbnailTableCell;
@class expanz_ui_NavigationManager;
@class MBProgressHUD;


@interface expanz_ui_ActivityInstanceViewController : UIViewController<expanz_service_ActivityClientDelegate,
        UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,
        MBProgressHUDDelegate> {

@private
    NSMutableDictionary* _subViewStateCache;
    MBProgressHUD* _loadingHud;
    id<expanz_service_ActivityClient> _activityClient;
    expanz_service_CreateActivityRequest* _activityRequest;
    expanz_ui_NavigationManager* _activityManager;
    UIImageView* _currentlyEditingImageView;
    UIButton* _closeTextViewButton;
}

@property(nonatomic, strong, readonly) NSArray* propertyNames;
@property(nonatomic, strong, readonly) expanz_model_ActivityMenuItem* activityDefinition;
@property(nonatomic, strong, readonly) expanz_model_ActivityInstance* activityInstance;
@property(nonatomic, strong, readonly) expanz_ui_ModelAdapter* modelAdapter;
@property(nonatomic, retain) IBOutlet UIActivityIndicatorView* spinner;



/**
 * Initialize a new activity instance view controller with the supplied activity and record identifier key.  
 */
- (id) initWithActivityDefinition:(expanz_model_ActivityMenuItem*)activityDefinition nibName:(NSString*)nibName
        initialKey:(NSString*)initialKey;

/**
 * Request model to update with new field value. 
 */
- (void) sendDeltaForField:(expanz_model_FieldInstance*)textField;

/**
 * Invoke a method on the model. 
 */
- (void) sendMethodInvocation:(NSString*)methodName;

- (void) hasUITableView:(UITableView*)tableView requestingDataBinding:(BOOL)dataBinding;

- (void) hasUITableView:(UITableView*)tableView requestingPopulateMethod:(NSString*)populateMethod;

- (void) hasUITableView:(UITableView*)tableView requestingQuery:(NSString*)query;

- (void) hasUITableView:(UITableView*)tableView requestingAutoPopulate:(BOOL)autoPopulate;

- (void) willCommenceEditForImageView:(UIButton*)sender;


@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstanceViewController expanz_ui_ActivityInstanceViewController;