////////////////////////////////////////////////////////////////////////////////
//
//  EXPANZ
//  Copyright 2008-2011 EXPANZ
//  All Rights Reserved.
//
//  NOTICE: Expanz permits you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////`


#import <Foundation/Foundation.h>
#import "expanz_ui_ActivityInstanceViewController.h"

@class expanz_ui_components_TableView;


@interface ESA_Sales_CustomerViewController : expanz_ui_ActivityInstanceViewController<UITableViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView* dataGrid;

@end

/* ================================================================================================================== */
@compatibility_alias CustomerViewController ESA_Sales_CustomerViewController;