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
#import "expanz_ui_SystemEventPresenter.h"


@interface expanz_ui_AlertBoxSystemEventPresenter : NSObject<expanz_ui_SystemEventPresenter>

@property (nonatomic, assign) id<UIAlertViewDelegate> delegate;

@end

/* ================================================================================================================== */
@compatibility_alias AlertBoxSystemEventPresenter expanz_ui_AlertBoxSystemEventPresenter;