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
#import "expanz_model_SessionContext.h"

SPEC_BEGIN(SessionContextSpec)

describe(@"Object creation", ^{
    
    __block SessionContext* contextHolder; 
    
    beforeEach(^{
        contextHolder = [[SessionContext alloc] initWithSessionToken:@"xxlkj3249" hasError:NO hasWarning:NO 
                                                                   message:nil];
    });

    it(@"should allow initialization with sessionToken, warning, error and message.", ^{
        assertThat(contextHolder.sessionToken, equalTo(@"xxlkj3249"));
    });
    
    it(@"should store global authentication details for subsequent retrieval.", ^{
        [SessionContext setGlobalContext:contextHolder];
        assertThat([SessionContext globalContext], notNilValue());
    });
       
    it(@"should allow the token to be set to a new one.", ^{
        [SessionContext setGlobalContext:contextHolder];
        assertThat([SessionContext globalContext], notNilValue());
        
        SessionContext* holder2 = [[SessionContext alloc] initWithSessionToken:@"adfafas" 
                                                            hasError:NO hasWarning:NO message:nil];
        [SessionContext setGlobalContext:holder2];
        assertThat([SessionContext globalContext], notNilValue());
        assertThat([SessionContext globalContext], isNot(equalTo(contextHolder)));

    });


    
    afterEach(^{
        [SessionContext setGlobalContext:nil];
    });
        
});


SPEC_END
