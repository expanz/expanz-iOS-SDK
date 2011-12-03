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
#import "expanz_model_GridData.h"
#import "expanz_model_TreeData.h"
#import "expanz_model_Column.h"
#import "expanz_model_Row.h"
#import "expanz_model_TextCell.h"
#import "expanz_model_File.h"
#import "expanz_model_Folder.h"


SPEC_BEGIN(RXMLElement_ActivityInstanceSpec)

    __block RXMLElement* activityElement;

    describe(@"Object creation", ^{

        beforeEach(^{
            NSString* xmlString = [TestResource withName:@"ESA_Sales_Calc_ActivityInstance.xml"];
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
            NSString* xmlString = [TestResource withName:@"ActivityWithMessage.xml"];
            RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString];
            activityElement = [rootElement child:@"ExecXResult.ESA.Activity"];
        });

        it(@"should add a message for each message in the xml response", ^{
            ActivityInstance* activityInstance = [activityElement asActivityInstance];
            assertThatInt([activityInstance.messages count], equalToInt(1));
        });
    });

    describe(@"Activity instance with grid data", ^{

        beforeEach(^{
            NSString* xmlString = [TestResource withName:@"ESA_Sales_Customer_ActivityInstance.xml"];
            RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString];
            activityElement = [rootElement child:@"ExecXResult.ESA.Activity"];
        });

        it(@"Should add expanz_model_Data objects for each grid data node.", ^{
            ActivityInstance* activity = [activityElement asActivityInstance];
            assertThatInt([activity.dataSets count], equalToInt(1));

            GridData* data = [activity.dataSets objectAtIndex:0];
            assertThat(data, notNilValue());
            assertThat(data.dataId, notNilValue());
            assertThat(data.source, notNilValue());

            //Columns
            assertThatInt([data.columns count], equalToInt(10));
            for (Column* column in [data columns]) {
                assertThat(column.columnId, notNilValue());
                assertThat(column.field, notNilValue());
                assertThat(column.label, notNilValue());
                assertThatBool(column.width > 0, equalToBool(YES));
            }

            //Rows
            assertThatInt([data.rows count], equalToInt(4));
            for (Row* row in [data rows]) {
                assertThat(row.rowId, notNilValue());
                assertThat(row.type, equalTo(@"Sales.Customer"));
                for (BaseCell* cell in [row cells]) {
                    assertThat(cell.cellId, notNilValue());
                }
            }
        });

    });

    describe(@"Activity instance with tree data.", ^{
        
        beforeEach(^{
            NSString* xmlString = [TestResource withName:@"Thermomix_DocumentMaintenance_Portal_ActivityInstance.xml"];
            RXMLElement* rootElement = [RXMLElement elementFromXMLString:xmlString];
            activityElement = [rootElement child:@"ExecXResult.ESA.Activity"];
        });

        it(@"Should add expamz_model_Data objects for each tree data node.", ^{
            ActivityInstance* activity = [activityElement asActivityInstance];
            assertThatInt([activity.dataSets count], equalToInt(1));

            TreeData* data = [activity.dataSets objectAtIndex:0];
            assertThat(data, notNilValue());
            assertThat(data.dataId, equalTo(@"DocumentsTree"));

            //Folders
            assertThatInt([data.folders count], equalToInt(24));
            Folder* folder = [data.folders objectAtIndex:0];
            for (File* file in [folder files]) {
                assertThat(file.fileId, notNilValue());
                LogDebug(@"File: %@", file);
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