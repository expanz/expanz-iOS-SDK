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

@class expanz_model_ActivityDefinition;

/**
* Responsible for navigating between activity views.
*/
@interface expanz_ui_NavigationManager : NSObject {

@private
    UINavigationController* _navigationController;
}

@property(nonatomic, strong) id<expanz_ui_SystemEventReporter> reporter;

- (BOOL) showMainMenu;

- (BOOL) showActivityWithDefinition:(expanz_model_ActivityDefinition*)activityDefinition;

- (BOOL) showActivityWithDefinition:(expanz_model_ActivityDefinition*)activityDefinition
                                 initialKey:(NSString*)initialKey;

- (BOOL)showDocument:(NSString*)documentId;

@end

/* ================================================================================================================== */
@compatibility_alias NavigationManager expanz_ui_NavigationManager;