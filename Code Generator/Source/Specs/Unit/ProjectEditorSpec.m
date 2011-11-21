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

SPEC_BEGIN(FooSpec)
describe(@"Foo", ^{
    beforeEach(^{
        
    });
    
    it(@"should do something", ^{
        LogDebug(@"Hello");
        assertThatInt(1, equalToInt(2));
    });
});
SPEC_END