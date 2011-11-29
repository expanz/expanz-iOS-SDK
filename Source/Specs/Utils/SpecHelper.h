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

#define __SPEC_HELPER


#define HC_SHORTHAND
#if TARGET_OS_IPHONE
#import <Cedar-iPhone/SpecHelper.h>
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#else
#import <Cedar/SpecHelper.h>
#import <OCHamcrest/OCHamcrest.h>
#endif

#import <objc/runtime.h>

#define AddToContext(key, value) [[SpecHelper specHelper].sharedExampleContext setObject:value forKey:key]
#define GetFromContext(key) [[SpecHelper specHelper].sharedExampleContext objectForKey:key]
#define SetTarget(value) AddToContext(@"target", value)
#define GetTarget() GetFromContext(@"target")

/* ================================================================================================================== */

#define NSINT(__i) ([NSNumber numberWithInt:__i])
#define NSDATE(__i) ([[[NSDate alloc] initWithString: __i] autorelease])

/* ================================================================================================================== */

#define assertWillHappen(expression) \
float sleepCount = 0; \
while ((!(expression)) && sleepCount < 9) { \
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];\
    usleep(50000); \
    sleepCount = sleepCount + 0.05; \
}\
NSString* outcome; \
if (expression)\
    outcome = @"expression happened before 9 seconds.";\
else\
    outcome = @"expression did not happen before 9 seconds.";\
assertThat(outcome, equalTo(@"expression happened before 9 seconds."))

/* ================================================================================================================== */

#import "expanz_model_SessionContext.h"
#import "expanz_iOS_SDKModule.h"
#import "TestResource.h"









