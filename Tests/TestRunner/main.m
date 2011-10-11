//
//  main.m
//  TestRunner
//
//  Created by Jasper Blues on 10/11/11.
//  Copyright 2011 EXPANZ. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    const char *prefix = "GCOV_PREFIX";
    const char *prefixValue = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
                               cStringUsingEncoding:NSASCIIStringEncoding];
    const char *prefixStrip = "GCOV_PREFIX_STRIP";
    const char *prefixStripValue = "1";
    // This sets an environment variable which tells gcov where to put the .gcda files.
    setenv(prefix, prefixValue, 1);
    // This tells gcov to strip the default prefix, and use the filepath that we just declared.
    setenv(prefixStrip, prefixStripValue, 1);
    
    
    //This lets the simulator get itself in order.
    [NSThread sleepForTimeInterval:0.5];
    int retVal = UIApplicationMain(argc, argv, nil, @"CedarApplicationDelegate");
    [pool release];
    return retVal; 
}
