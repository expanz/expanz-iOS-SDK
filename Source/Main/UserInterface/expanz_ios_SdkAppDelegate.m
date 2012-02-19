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

#import "Objection.h"
#import "expanz_ios_SdkAppDelegate.h"
#import "expanz_ios_SdkModule.h"
#import "expanz_ui_LoginViewController.h"



@implementation expanz_ios_SdkAppDelegate

@synthesize window = _window;
@synthesize navigationController = _navigationController;


/* ================================================ Delegate Methods ================================================ */

- (BOOL) application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)launchOptions {
    
    JSObjectionInjector* injector = [JSObjection createInjector:[[SdkModule alloc] init]];
    [JSObjection setGlobalInjector:injector];
    LoginViewController* loginViewController = [[LoginViewController alloc] init];
    [_navigationController pushViewController:loginViewController animated:NO];
    [_navigationController setNavigationBarHidden:YES];
    [self.window addSubview: [_navigationController view]];
    [self.window makeKeyAndVisible];    

    return YES;
}


//- (void) applicationWillResignActive:(UIApplication*)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of 
     temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and 
     it begins the transition to the background state. 
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use 
     this method to pause the game.
     */
//}

//- (void) applicationDidEnterBackground:(UIApplication*)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state 
     information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when 
     the user quits.
     */
//}

//- (void) applicationWillEnterForeground:(UIApplication*)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes 
     made on entering the background.
     */
//}

//- (void) applicationDidBecomeActive:(UIApplication*)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was 
     previously in the background, optionally refresh the user interface.
     */
//}

//- (void)applicationWillTerminate:(UIApplication*)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
//}


@end
