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

#import <UIKit/UIKit.h>
#import "NSObject+ExpanzConfiguration.h"

int main(int argc, char *argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    //This is normally invoked on main window, via interface builder. But we can invoke it on any object, to get 
    //environment configuration done. It points to an XML file called expanz.xml
    [pool setExpanzConfiguration:@"expanz"];
    //This lets the simulator get itself in order.
    [NSThread sleepForTimeInterval:0.5];
    int retVal = UIApplicationMain(argc, argv, nil, @"CedarApplicationDelegate");
    [pool release];
    return retVal; 
}
