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
#import "expanz_model_ActivityDefinition.h"


SPEC_BEGIN(ActivityManagerSpec)

    describe(@"Transitioning from a menu or activity to another activity view", ^{

        __block ActivityManager* activityManager;
        __block StubSystemEventReporter* reporter;

        beforeEach(^{
            activityManager = [[[ActivityManager alloc] init] autorelease];
            reporter = [[[StubSystemEventReporter alloc] init] autorelease];
            activityManager.reporter = reporter;
        });

        it(@"should transition to the activity according to activity definition", ^{

            ActivityDefinition* definition = [[ActivityDefinition alloc]
                initWithName:@"TestFixture" title:@"TestFixture" style:[ActivityStyle defaultStyle]];

            [activityManager transitionToActivityWithDefinition:definition];
        });

        it(@"should report an error if the activity requires a controller that doesn't exist", ^{

            ActivityDefinition* definition = [[ActivityDefinition alloc]
                initWithName:@"My.Fun.Documents" title:@"My Fun Documents" style:[ActivityStyle browseStyle]];

            [activityManager transitionToActivityWithDefinition:definition];
            assertThat(reporter.message, equalTo(@"No controller exists named My_Fun_Documents_Browse_ViewController"));

        });

    });

    SPEC_END