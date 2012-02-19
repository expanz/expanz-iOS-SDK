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

#import "expanz_ios_SdkConfiguration.h"
#import <UIKit/UIKit.h>

/**
* Run with the argument 'Harness' to run ActivityHarness, otherwise runs all specs.
*/
int main(int argc, char* argv[]) {


    @autoreleasepool {
        if (argc == 2 && strcmp(argv[1], "Harness") == 0) {
            return UIApplicationMain(argc, argv, nil, @"ActivityHarnessApplicationDelegate");
        }
        else {
            SdkConfiguration* configuration = [[SdkConfiguration alloc]
                initWithBaseUrl:@"http://expanzdemo.cloudapp.net:8080/ESAService.svc/restish" preferredSite:@"SALES"
                       userType:@"Alternate"];
            [SdkConfiguration setGlobalConfiguration:configuration];

            //This lets the simulator get itself in order.
            [NSThread sleepForTimeInterval:0.5];
            return UIApplicationMain(argc, argv, nil, @"CedarApplicationDelegate");
        }
    }

}
