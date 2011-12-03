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
#import "expanz_ui_ActivityManager.h"
#import "StubSystemEventReporter.h"


SPEC_BEGIN(ActivityManagerSpec)

    describe(@"Transitioning from a menu or activity to another activity view", ^{
        
        __block ActivityManager* activityManager;
        
        beforeEach(^{
            activityManager = [[[ActivityManager alloc] init] autorelease];
            StubSystemEventReporter* reporter = [[[StubSystemEventReporter alloc] init] autorelease];
            activityManager.reporter = reporter; 
        });
        
        it(@"", ^{
            
        });
        
    
    });

SPEC_END