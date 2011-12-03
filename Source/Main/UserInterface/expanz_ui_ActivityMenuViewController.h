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
#import "expanz_service_SessionDataClient.h"
#import "expanz_service_SessionDataClientDelegate.h"
#import "expanz_ui_SystemEventPresenter.h"

@class expanz_model_Menu;
@class expanz_ui_ActivityManager;


@interface expanz_ui_ActivityMenuViewController : UIViewController<expanz_service_SessionDataClientDelegate> {

@private
    expanz_ui_ActivityManager* _activityManger;
}
        
@property (nonatomic, readonly) id<expanz_service_SessionDataClient> sessionDataClient; 
@property (nonatomic, readonly) expanz_model_Menu* menu;
@property (nonatomic, retain) IBOutlet UITableView* menuTable;

@end

/* ================================================================================================================== */
@compatibility_alias ActivityMenuViewController expanz_ui_ActivityMenuViewController;
