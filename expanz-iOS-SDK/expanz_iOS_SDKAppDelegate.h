//
//  expanz_iOS_SDKAppDelegate.h
//  expanz-iOS-SDK
//
//  Created by Jasper Blues on 9/27/11.
//  Copyright 2011 Expanz Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class expanz_iOS_SDKViewController;

@interface expanz_iOS_SDKAppDelegate : NSObject <UIApplicationDelegate>

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet expanz_iOS_SDKViewController *viewController;

@end
