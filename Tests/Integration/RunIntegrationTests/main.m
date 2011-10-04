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

int main(int argc, char *argv[]) {  
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];    
    int retVal = UIApplicationMain(argc, argv, nil, @"CedarApplicationDelegate");
    [pool release];
    return retVal;    
}
