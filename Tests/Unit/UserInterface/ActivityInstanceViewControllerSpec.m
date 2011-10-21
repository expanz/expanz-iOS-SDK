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

#import "SpecHelper.h"
#import "MARTNSObject.h"
#import "RTProtocol.h"
#import "RTIvar.h"
#import "RTProperty.h"
#import "RTMethod.h"
#import "RTUnregisteredClass.h"
#import "expanz_ui_ActivityInstanceViewController.h"


SPEC_BEGIN(ActivityInstanceViewControllerSpec)

describe(@"objc runtime. . . ", ^{
    
    it(@"should do some cool stuff", ^{
        
        NSString* field = @"ResultField";
        
        NSString* substring = [field substringToIndex:[field rangeOfString:@"Field"].location];
        
        LogDebug(@"The field!!!!!!!!! %@", substring);
        
        NSArray* methods = [ActivityInstanceViewController rt_methods]; 
        for (RTMethod* method in methods) {
            if ([[method selectorName] hasSuffix:@"Field"]) {
                LogDebug(@"%@", [method selectorName]);
            }

        }

        
    });
    
});

SPEC_END