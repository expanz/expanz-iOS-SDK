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
#import "expanz_model_ActivityStyle.h"

@class expanz_model_FieldInstance;
@class expanz_ui_ModelAdapter;
@class expanz_service_CreateActivityRequest;
@class expanz_ui_components_ThumbnailTableCell;
@class expanz_ui_NavigationManager;
@class MBProgressHUD;
@class expanz_model_MenuItem;
@class expanz_model_ActivityStyle;


@interface expanz_ui_ActivityInstanceViewController : UIViewController<expanz_service_ActivityClientDelegate,
        UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate,
        MBProgressHUDDelegate> {

@private
    NSMutableDictionary* _subViewStateCache;
    MBProgressHUD* _loadingHud;
    id<expanz_service_ActivityClient> _activityClient;
    expanz_service_CreateActivityRequest* _activityRequest;
    expanz_ui_NavigationManager* _navigationManager;
    UIImageView* _currentlyEditingImageView;
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
        initialKey:(NSString*)initialKey nibName:(NSString*)nibName;

/**
* Creates or retrieves an instance of the activity on the remote server using the specified data key.
*/
- (void) attachToServerWithInitialKey:(NSString*)initialKey;

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