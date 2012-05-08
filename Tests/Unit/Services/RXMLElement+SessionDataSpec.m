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


#import "RXMLElement+SessionData.h"
#import "expanz_model_Menu.h"
#import "expanz_model_ProcessArea.h" 
#import "expanz_model_menuItem.h"
#import "expanz_utils_BundleResource.h"

SPEC_BEGIN(RXMLELement_SessionDataSpec)

        __block RXMLElement* element;

        beforeEach(^{
            NSString* xmlString = [BundleResource withName:@"SessionData.xml"];
            element = [RXMLElement elementFromXMLString:xmlString encoding:NSUTF8StringEncoding];
        });


        describe(@"Object intantiation", ^{

            it(@"should return a menu instance for from XML data.", ^{
                Menu* menu = [[element child:@"ExecXResult.ESA.Menu"] asMenu];
                LogDebug(@"%@", menu);
                [menu shouldNotBeNil];
            });
        });

        describe(@"Parsing children", ^{

            it(@"should include the style attribute on ProcessArea.Activity children, where necessary.", ^{
                Menu* menu = [[element child:@"ExecXResult.ESA.Menu"] asMenu];
                ProcessArea* processArea = [menu processAreaWithId:@"Sales"];
                MenuItem* activity = [processArea menuItemWithName:@"ESA.Sales.Customer"];
                [activity shouldNotBeNil];
                [[theValue([activity.style isBrowse]) should] beYes];
            });

        });

        describe(@"Error handling", ^{
            it(@"should throw XML validation exception if you pass it the wrong kind of element", ^{
                NSString* xmlString = [BundleResource withName:@"Dodgy.xml"];
                RXMLElement* element = [RXMLElement elementFromXMLString:xmlString encoding:NSUTF8StringEncoding];

                @try {
                    [element asMenu];
                    [NSException raise:@"Should have thrown exception" format:@"Assertion failed"];
                }
                @catch (NSException* e) {
                    [[[e reason] should] equal:@"Element is not a Menu."];
                }

                @try {
                    [element asProcessArea];
                    [NSException raise:@"Should have thrown exception" format:@"Assertion failed"];
                }
                @catch (NSException* e) {
                    [[[e reason] should] equal:@"Element is not a ProcessArea."];
                }

                @try {
                    [element asUserRole];
                    [NSException raise:@"Should have thrown exception" format:@"Assertion failed"];
                }
                @catch (NSException* e) {
                    [[[e reason] should] equal:@"Element is not a UserRole."];
                }

            });
        });



        SPEC_END