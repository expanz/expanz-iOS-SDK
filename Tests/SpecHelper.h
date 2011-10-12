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



#define NSINT(__i) ([NSNumber numberWithInt:__i])
#define NSDATE(__i) ([[[NSDate alloc] initWithString: __i] autorelease])

void assertRaises(void(^block)(), NSString *expectedReason);




