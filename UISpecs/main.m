//
//  main.m
//  UISpecs
//
//  Created by Jasper Blues on 9/29/11.
//  Copyright 2011 EXPANZ. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    int retVal = UIApplicationMain(argc, argv, nil, @"CedarApplicationDelegate");
    [pool release];
    return retVal;
}
