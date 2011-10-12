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

#import "RXMLElement+ActivityInstance.h"
#import "expanz_iOS_SDKExceptions.h"

@implementation RXMLElement (ActivityInstance)

- (ActivityInstance*) asActivityInstance {
    if (![self.tag isEqualToString:@"Menu"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not an Activity."];
    }
    return nil;
}

@end
