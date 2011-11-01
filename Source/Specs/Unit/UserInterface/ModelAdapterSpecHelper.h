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

@class expanz_ui_ModelAdapter;
@class expanz_ui_ActivityInstanceViewController;

/* ================================================================================================================== */
//Stub a navigation controller on the Cedar Application Delegate - expected to be there by CustomerViewController.
@interface CedarApplicationDelegate
@end

@implementation CedarApplicationDelegate (private)
- (UINavigationController*) navigationController {
    return nil;
}
@end
/* ================================================================================================================== */

@interface ModelAdapterSpecHelper : NSObject

+ (expanz_ui_ModelAdapter*) modelAdapterWith:(expanz_ui_ActivityInstanceViewController*)controller
                                 xmlFileName:(NSString*)fileName;

@end