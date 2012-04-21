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


#import "expanz_ui_NavigationManager.h"
#import "StubSystemEventReporter.h"
#import "expanz_model_menuItem.h"


SPEC_BEGIN(NavigationManagerSpec)

        describe(@"Transitioning from a menu or activity to another activity view", ^{

            __block NavigationManager* activityManager;
            __block StubSystemEventReporter* reporter;

            beforeEach(^{
                activityManager = [[NavigationManager alloc] init];
                reporter = [[StubSystemEventReporter alloc] init];
                activityManager.reporter = reporter;
            });

            it(@"should transition to the activity according to activity definition", ^{

                MenuItem* menuItem = [[MenuItem alloc]
                        initWithActivityId:@"TestFixture" title:@"TestFixture" style:[ActivityStyle defaultStyle]];

                [activityManager showActivity:menuItem];
            });

            it(@"should report an error if the activity requires a controller that doesn't exist", ^{

                MenuItem* menuItem = [[MenuItem alloc]
                        initWithActivityId:@"My.Fun.Documents" title:@"My Fun Documents"
                        style:[ActivityStyle browseStyle]];

                [activityManager showActivity:menuItem];
                [[reporter.message should] equal:@"No controller exists named My_Fun_Documents_Browse_ViewController"];

            });

        });

        SPEC_END