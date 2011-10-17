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

@interface expanz_ui_ActivityInstanceViewController : UIViewController<expanz_service_CreateActivityClientDelegate>

@property (nonatomic, readonly) id<expanz_service_ActivityClient> activityClient; 

-(id) initWithActivity:(Activity*)activity; 

@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstanceViewController expanz_ui_ActivityInstanceViewController;