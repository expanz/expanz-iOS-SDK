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

#import "RXMLElement+ActivityInstance.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_GridData.h"
#import "expanz_model_TreeData.h"
#import "expanz_model_Column.h"
#import "expanz_model_Row.h"
#import "expanz_model_TextGridDataCell.h"
#import "expanz_model_File.h"
#import "expanz_model_Folder.h"
#import "TestResource.h"


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
            [activityInstance shouldNotBeNil];
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
            [[[activityInstance messages] should] haveCountOf:1];            
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
            [[[activity dataSets] should] haveCountOf:1];            

            GridData* data = [activity.dataSets objectAtIndex:0];
            [data shouldNotBeNil];
            [[data dataId] shouldNotBeNil];
            [[data source] shouldNotBeNil];

            //Columns
            [[[data columns] should] haveCountOf:10];             
            for (Column* column in [data columns]) {
                [[column columnId] shouldNotBeNil];
                [[column fieldId] shouldNotBeNil];
                [[column label] shouldNotBeNil];
                [[theValue([column width]) should] beGreaterThan:theValue(0)];
            }

            //Rows
            [[[data rows] should] haveCountOf:4];            
            for (Row* row in [data rows]) {
                [[row rowId] shouldNotBeNil];
                [[[row type] should] equal:@"Sales.Customer"];
                
                for (AbstractGridDataCell* cell in [row cells]) {
                    [[cell cellId] shouldNotBeNil];
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
            [[[activity dataSets] should] haveCountOf:1];            

            TreeData* data = [activity.dataSets objectAtIndex:0];
            [data shouldNotBeNil];
            [[[data dataId] should] equal:@"DocumentsTree"];            

            //Folders
            [[[data folders] should] haveCountOf:24];            
            Folder* folder = [data.folders objectAtIndex:0];
            for (File* file in [folder files]) {
                [[file fileId] shouldNotBeNil];
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
                [[[exception name]  should] equal:NSInvalidArgumentException];
            }

        });

        it(@"should throw NSException if you feed it the wrong kind of field.", ^{
            @try {
                [e asField];
                [NSException raise:@"Should have thrown exception" format:@"Fed the wrong kind of element"];
            }
            @catch (NSException* exception) {
                [[[exception name] should] equal:NSInvalidArgumentException];
            }
        });

        it(@"should NSException if you feed it the wrong kind of messages.", ^{
            @try {
                [e asMessage];
                [NSException raise:@"Should have thrown exception" format:@"Fed the wrong kind of element"];
            }
            @catch (NSException* exception) {
                [[[exception name] should] equal:NSInvalidArgumentException];
            }

        });

    });

    SPEC_END