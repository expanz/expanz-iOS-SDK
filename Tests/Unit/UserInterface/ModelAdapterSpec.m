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

#import "expanz_model_menuItem.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_ui_ModelAdapter.h"
#import "expanz_model_GridData.h"
#import "expanz_utils_BundleResource.h"
#import "RXMLElement+ActivityInstance.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_ActivityControllerBuilder.h"
#import "Sales_Customer_ViewController.h"
#import "Sales_Customer_Browse_ViewController.h"


SPEC_BEGIN(ModelAdapterSpec)

        __block Sales_Customer_ViewController* viewController;
        __block ModelAdapter* modelAdapter;

        beforeEach(^{

            viewController =
                    (Sales_Customer_ViewController*) [[ActivityControllerBuilder forActivityId:@"Sales.Customer"]
                            build];

            [viewController shouldNotBeNil];
            [viewController.view shouldNotBeNil];

            NSString* xml = [BundleResource withName:@"ESA_Sales_Customer_ActivityInstance.xml"];
            ActivityInstance* activityInstance = [[[RXMLElement elementFromXMLString:xml encoding:NSUTF8StringEncoding]
                    child:@"ExecXResult.ESA.Activity"] asActivityInstance];
            [viewController requestDidFinishWithActivityInstance:activityInstance];
            modelAdapter = viewController.modelAdapter;
        });

        describe(@"Object creation", ^{

            it(@"should be created by ActivityInstanceViewController after receiving activity data", ^{

                modelAdapter = viewController.modelAdapter;
                [modelAdapter shouldNotBeNil];
            });

        });

        describe(@"Mapping UITextField controls to expanz_model_Field items in an ActivityInstance", ^{


            it(@"should return the Field corresponding to a UITextField", ^{
                Field* field = [modelAdapter fieldFor:viewController.FirstName];
                [field shouldNotBeNil];
                [[field.fieldId should] equal:@"FirstName"];
            });

            it(@"should map the other way - return a UITextField for an expanz_model_field. ", ^{
                Field* field = [modelAdapter.activityInstance fieldWithId:@"FirstName"];
                id textControl = [modelAdapter textFieldFor:field];
                [textControl shouldNotBeNil];
                LogDebug(@"Text Control: %@", textControl);
            });

        });

        describe(@"Updating user interface controls with model values.", ^{


            it(@"should update each user interface control with the corresponding model value. ", ^{

                Field* firstName = [modelAdapter.activityInstance fieldWithId:@"FirstName"];
                firstName.value = @"9999";

                [modelAdapter updateUIControlsWithModelValues];
                UITextField* textField = (UITextField*) viewController.FirstName;
                [[[textField text] should] equal:@"9999"];
            });

        });

        describe(@"Mapping UITableView controls to expanz_model_DataSet items in an ActivityInstance", ^{

            beforeEach(^{
                ActivityControllerBuilder* builder = [ActivityControllerBuilder forActivityId:@"Sales.Customer"];
                [builder setActivityStyle:[ActivityStyle browseStyle]];
                viewController = [builder build];
                [viewController shouldNotBeNil];
                [viewController.view shouldNotBeNil];

                NSString* xml = [BundleResource withName:@"ESA_Sales_Customer_ActivityInstance.xml"];
                RXMLElement* element = [[RXMLElement elementFromXMLString:xml encoding:NSUTF8StringEncoding]
                        child:@"ExecXResult.ESA.Activity"];
                ActivityInstance* activityInstance = [element asActivityInstance];
                LogDebug(@"@@@@@@@@@@@@@@@@@@@@@@@@Activity instance: %@", activityInstance.dataSets);

                [viewController requestDidFinishWithActivityInstance:activityInstance];
                modelAdapter = viewController.modelAdapter;


            });

            it(@"should return a UITableView corresponding to a DataSet", ^{
                GridData* dataSet = (GridData*) [modelAdapter.activityInstance dataWithId:@"ListCustomersMobile"];
                [dataSet shouldNotBeNil];
                UITableView* tableView = [modelAdapter tableViewFor:dataSet];
                [tableView shouldNotBeNil];
            });

        });


        SPEC_END


