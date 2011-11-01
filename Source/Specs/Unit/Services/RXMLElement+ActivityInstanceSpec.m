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
#import "RXMLElement+ActivityInstance.h"
#import "expanz_model_ActivityInstance.h"
#import "../../../Main/Model/expanz_model_DataSet.h"
#import "expanz_model_DataSet.h"
#import "expanz_model_Column.h"


SPEC_BEGIN(RXMLElement_ActivityInstanceSpec)

    __block RXMLElement* activityElement;

    describe(@"Object creation", ^{

        beforeEach(^{
            NSString
                * filePath = [[NSBundle mainBundle] pathForResource:@"ESA_Sales_Calc_ActivityInstance" ofType:@"xml"];
            NSString* xmlString =
                [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString];
            activityElement = [rootElement child:@"ExecXResult.ESA.Activity"];
        });


        it(@"should return an ActivityIntance from corresponding XML", ^{
            ActivityInstance* activityInstance = [activityElement asActivityInstance];
            assertThat(activityInstance, notNilValue());
        });


    });

    describe(@"An activity with messages.", ^{

        beforeEach(^{
            NSString* filePath = [[NSBundle mainBundle] pathForResource:@"ActivityWithMessage" ofType:@"xml"];
            NSString* xmlString =
                [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString];
            activityElement = [rootElement child:@"ExecXResult.ESA.Activity"];
        });

        it(@"should add a message for each message in the xml response", ^{
            ActivityInstance* activityInstance = [activityElement asActivityInstance];
            assertThatInt([activityInstance.messages count], equalToInt(1));
        });
    });

    describe(@"Activity instance with data", ^{

        beforeEach(^{
            NSString* filePath =
                [[NSBundle mainBundle] pathForResource:@"ESA_Sales_Customer_ActivityInstance" ofType:@"xml"];
            NSString* xmlString =
                [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
            RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString];
            activityElement = [rootElement child:@"ExecXResult.ESA.Activity"];
        });

        it(@"Should add expanz_model_Data objects for each data node.", ^{
            ActivityInstance* activity = [activityElement asActivityInstance];
            assertThatInt([activity.dataSets count], equalToInt(1));
            
            DataSet* data = [activity.dataSets objectAtIndex:0]; 
            assertThat(data, notNilValue());
            assertThat(data.dataId, notNilValue());
            assertThat(data.source, notNilValue());
            
            //Columns
            assertThatInt([data.columns count], equalToInt(2));
            for (Column* column in [data columns]) {
                assertThat(column.columnId, notNilValue());
                assertThat(column.field, notNilValue());
                assertThat(column.dataType, notNilValue());
                assertThat(column.label, notNilValue());
                assertThatBool(column.width > 0, equalToBool(YES));
            }
        });

    });


    describe(@"Error handling", ^{

        __block RXMLElement* e;

        beforeEach(^{
            e = [RXMLElement elementFromXMLString:@"<wrong><xml>this is the wrong xml.</xml></wrong>"];
        });

        it(@"should throw NSException if you feed it the wrong kind of activity.", ^{

            @try {
                [e asActivityInstance];
                [NSException raise:@"Should have thrown exception" format:@"Fed the wrong kind of element"];
            }
            @catch (NSException* exception) {
                assertThat([exception name], equalTo(ExXmlValidationException));
            }

        });

        it(@"should throw NSException if you feed it the wrong kind of field.", ^{
            @try {
                [e asField];
                [NSException raise:@"Should have thrown exception" format:@"Fed the wrong kind of element"];
            }
            @catch (NSException* exception) {
                assertThat([exception name], equalTo(ExXmlValidationException));
            }
        });

        it(@"should NSException if you feed it the wrong kind of messages.", ^{
            @try {
                [e asMessage];
                [NSException raise:@"Should have thrown exception" format:@"Fed the wrong kind of element"];
            }
            @catch (NSException* exception) {
                assertThat([exception name], equalTo(ExXmlValidationException));
            }

        });

    });

SPEC_END