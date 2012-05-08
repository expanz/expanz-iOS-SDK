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


#import "expanz_model_AbstractGridDataCell.h"
#import "expanz_model_Row.h"
#import "expanz_model_Column.h"
#import "expanz_model_GridData.h"
#import "RXMLElement+ActivityInstance.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_utils_BundleResource.h"

SPEC_BEGIN(RXMLElement_ActivityInstancePeopleScec)

        __block RXMLElement* activityElement;

        describe(@"Grid data with a context object", ^{

            beforeEach(^{
                NSString* xmlString = [BundleResource withName:@"erp365CRM.Person.xml"];
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


        SPEC_END