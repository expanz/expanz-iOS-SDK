//
//  UISpecsAppDelegate.h
//  UISpecs
//
//  Created by Jasper Blues on 9/29/11.
//  Copyright 2011 EXPANZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UISpecsViewController;

@interface UISpecsAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UISpecsViewController *viewController;

@end
