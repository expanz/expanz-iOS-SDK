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
#import "CedarApplicationDelegate+Expanz.h"


@implementation CedarApplicationDelegate (Expanz)

- (UINavigationController*)navigationController {
    LogDebug(@"Returning fake navigation controller");
    return nil;
}


@end