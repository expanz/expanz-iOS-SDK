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

#import "expanz_iOS_SDKConfiguration.h"

int main(int argc, char* argv[]) {


    @autoreleasepool {
        SDKConfiguration* configuration = [[SDKConfiguration alloc]
            initWithBaseUrl:@"http://expanzdemo.cloudapp.net:8080/ESAService.svc/restish" preferredSite:@"SALES"
                   userType:@"Alternate"];
        [SDKConfiguration setGlobalConfiguration:configuration];

        //This lets the simulator get itself in order.
        [NSThread sleepForTimeInterval:0.5];
        return UIApplicationMain(argc, argv, nil, @"CedarApplicationDelegate");
    }

}
