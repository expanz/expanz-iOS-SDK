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

@interface expanz_ui_ActivityViewController : UIViewController<expanz_service_SessionDataClientDelegate>
        
@property (nonatomic, readonly) id<expanz_service_SessionDataClient> sessionDataClient; 

@end

/* ================================================================================================================== */
@compatibility_alias ActivityViewController expanz_ui_ActivityViewController;
