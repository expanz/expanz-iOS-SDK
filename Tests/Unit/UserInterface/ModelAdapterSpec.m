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

#import "expanz_model_ActivityDefinition.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_ui_ModelAdapter.h"
#import "expanz_model_GridData.h"
#import "RXMLElement.h"
#import "RXMLElement+ActivityInstance.h"
#import "TestFixture_ViewController.h"
#import "TestResource.h"


SPEC_BEGIN(ModelAdapterSpec)

    __block TestFixture_ViewController* viewController;
    __block ModelAdapter* modelAdapter;

    beforeEach(^{
        ActivityDefinition* activity =
            [[ActivityDefinition alloc] initWithName:@"ESA.Sales.Calc" title:@"Calc" style:[ActivityStyle defaultStyle]];
        viewController = [[TestFixture_ViewController alloc]
            initWithActivityDefinition:activity nibName:@"TestFixtureView" initialKey:nil];
        [viewController shouldNotBeNil];
        [viewController.view shouldNotBeNil];
    });

    describe(@"Object creation", ^{

        it(@"should be created by ActivityInstanceViewController after receiving activity data", ^{
            NSString* xml = [TestResource withName:@"ESA_Sales_Calc_ActivityInstance.xml"];
            ActivityInstance* activityInstance =
                [[[RXMLElement elementFromXMLString:xml] child:@"ExecXResult.ESA.Activity"] asActivityInstance];
            [viewController requestDidFinishWithActivityInstance:activityInstance];

            modelAdapter = viewController.modelAdapter;
            [modelAdapter shouldNotBeNil];
        });

    });

    describe(@"Mapping UITextField controls to expanz_model_Field items in an ActivityInstance", ^{

        beforeEach(^{
            NSString* xml = [TestResource withName:@"ESA_Sales_Calc_ActivityInstance.xml"];
            ActivityInstance* activityInstance =
                [[[RXMLElement elementFromXMLString:xml] child:@"ExecXResult.ESA.Activity"] asActivityInstance];
            [viewController requestDidFinishWithActivityInstance:activityInstance];
            modelAdapter = viewController.modelAdapter;
        });

        it(@"should return the Field corresponding to a UITextField", ^{
            Field* field = [modelAdapter fieldFor:viewController.Op1];
            [field shouldNotBeNil];
            [[field.fieldId should] equal:@"Op1"];
        });

        it(@"should map the other way - return a UITextField for an expanz_model_field. ", ^{
            Field* field = [modelAdapter.activityInstance fieldWithId:@"Op2"];
            id textControl = [modelAdapter textFieldFor:field];
            [textControl shouldNotBeNil];
            LogDebug(@"Text Control: %@", textControl);
        });

    });

    describe(@"Updating user interface controls with model values.", ^{

        beforeEach(^{
            NSString* xml = [TestResource withName:@"ESA_Sales_Calc_ActivityInstance.xml"];
            ActivityInstance* activityInstance =
                [[[RXMLElement elementFromXMLString:xml] child:@"ExecXResult.ESA.Activity"] asActivityInstance];
            [viewController requestDidFinishWithActivityInstance:activityInstance];
            modelAdapter = viewController.modelAdapter;
        });

        it(@"should update each user interface control with the corresponding model value. ", ^{

            Field* op1 = [modelAdapter.activityInstance fieldWithId:@"Op1"];
            op1.value = @"9999";

            [modelAdapter updateUIControlsWithModelValues];
            [[viewController.Op1.text should] equal:@"9999"];
        });

    });

    describe(@"Mapping UITableView controls to expanz_model_DataSet items in an ActivityInstance", ^{

        beforeEach(^{
            NSString* xml = [TestResource withName:@"ESA_Sales_Customer_ActivityInstance.xml"];
            ActivityInstance* activityInstance =
                [[[RXMLElement elementFromXMLString:xml] child:@"ExecXResult.ESA.Activity"] asActivityInstance];
            [viewController requestDidFinishWithActivityInstance:activityInstance];
            modelAdapter = viewController.modelAdapter;
        });

        it(@"should return a UITableView corresponding to a DataSet", ^{
            GridData* dataSet = (GridData*) [modelAdapter.activityInstance dataWithId:@"customersList"];
            UITableView* tableView = [modelAdapter tableViewFor:dataSet];
            [tableView shouldNotBeNil];
        });

    });


SPEC_END

