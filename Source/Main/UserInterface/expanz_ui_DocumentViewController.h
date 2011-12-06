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


@interface expanz_ui_DocumentViewController : UIViewController

@property (nonatomic, retain) IBOutlet UIWebView* documentView;

@end

/* ================================================================================================================== */
@compatibility_alias DocumentViewController expanz_ui_DocumentViewController;