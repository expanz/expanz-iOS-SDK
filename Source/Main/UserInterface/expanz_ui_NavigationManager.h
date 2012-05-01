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
#import "Objection.h"
#import "expanz_ui_SystemEventReporter.h"

@class expanz_model_MenuItem;
@class expanz_ui_ActivityInstanceViewController;
@class expanz_ui_DocumentViewController;
@class expanz_ui_ActivityMenuViewController;

/**
* Responsible for navigating between activity views.
*/
@interface expanz_ui_NavigationManager : NSObject {

@private
    UINavigationController* _navigationController;
}

@property(nonatomic, strong) id<expanz_ui_SystemEventReporter> reporter;

- (expanz_ui_ActivityMenuViewController*) showMainMenu;

- (expanz_ui_ActivityInstanceViewController*) showActivityFor:(expanz_model_MenuItem*)menuItem;

- (expanz_ui_ActivityInstanceViewController*) showActivityFor:(expanz_model_MenuItem*)menuItem
        initialKey:(NSString*)initialKey;

- (expanz_ui_DocumentViewController*) showDocument:(NSString*)documentId;

@end

/* ================================================================================================================== */
@compatibility_alias NavigationManager expanz_ui_NavigationManager;