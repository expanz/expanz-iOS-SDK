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
#import "ExpanzActivityClient.h"
#import "MBProgressHUD.h"
#import "expanz_model_ActivityStyle.h"

@class expanz_model_Field;
@class expanz_ui_ModelAdapter;
@class expanz_service_CreateActivityRequest;
@class expanz_ui_components_ThumbnailTableCell;
@class expanz_ui_NavigationManager;
@class MBProgressHUD;
@class expanz_model_MenuItem;
@class expanz_model_ActivityStyle;
@class expanz_model_ActivityInstance;


@interface expanz_ui_ActivityInstanceViewController : UIViewController<ExpanzActivityClientDelegate,
        UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,
        MBProgressHUDDelegate> {

@private
    NSMutableDictionary* _subViewStateCache;
    MBProgressHUD* _loadingHud;
    id<ExpanzActivityClient> _activityClient;
    expanz_service_CreateActivityRequest* _activityRequest;
    expanz_ui_NavigationManager* _navigationManager;
    UIImageView* _currentlyEditingImageView;
    BOOL _shouldInitializeModelAdapterOnNextResponse;
}

@property(nonatomic, strong, readonly) NSString* activityId;
@property(nonatomic, strong, readonly) ActivityStyle* style;
@property(nonatomic, strong, readonly) expanz_model_ActivityInstance* activityInstance;
@property(nonatomic, strong, readonly) expanz_ui_ModelAdapter* modelAdapter;
@property(nonatomic, weak) IBOutlet UIActivityIndicatorView* spinner;
@property(nonatomic, weak) IBOutlet UISearchBar* searchBar;

//TODO: This should be private
@property(nonatomic, strong, readonly) NSArray* propertyNames;


/**
 * Initialize a new activity instance view controller with the supplied parameters. It is recommended to use a
 * `ActivityInstanceControllerBuilder` to obtain a controller instance.
 */
- (id) initWithActivityId:(NSString*)activityId title:(NSString*)title style:(expanz_model_ActivityStyle*)style
        initialKey:(NSString*)initialKey nibName:(NSString*)nibName data:(expanz_model_ActivityInstance*)data;

/**
* Creates or retrieves an instance of the activity on the remote server using the specified data key.
*/
- (void) attachToServerWithInitialKey:(NSString*)initialKey;

/**
 * Request model to update with new field value. 
 */
- (void) sendDeltaForField:(expanz_model_Field*)textField;

/**
 * Invoke a method on the model, attaching the results to self.
 */
- (void) sendMethodInvocation:(NSString*)methodName;

/**
* Invoke a method on the model, attaching the results to another controller;
*/
- (void) sendMethodInvocation:(NSString*)methodName withDelegate:(expanz_ui_ActivityInstanceViewController*)delegate;


- (void) hasUITableView:(UITableView*)tableView requestingDataBinding:(BOOL)dataBinding;

- (void) hasUITableView:(UITableView*)tableView requestingPopulateMethod:(NSString*)populateMethod;

- (void) hasUITableView:(UITableView*)tableView requestingQuery:(NSString*)query;

- (void) hasUITableView:(UITableView*)tableView requestingAutoPopulate:(BOOL)autoPopulate;

- (void) willCommenceEditForImageView:(UIButton*)sender;


@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstanceViewController expanz_ui_ActivityInstanceViewController;