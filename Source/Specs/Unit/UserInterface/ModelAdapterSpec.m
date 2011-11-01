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
#import "expanz_model_ActivityDefinition.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_ui_ModelAdapter.h"
#import "ESA_Sales_CalcViewController.h"
#import "ModelAdapterSpecHelper.h"
#import "ESA_Sales_CustomerViewController.h"
#import "expanz_model_DataSet.h"


SPEC_BEGIN(ModelAdapterSpec)

    __block CalcViewController* calcViewController;
    __block ModelAdapter* calcModelAdapter;

    beforeEach(^{
        ActivityDefinition
            * activity = [[ActivityDefinition alloc] initWithName:@"ESA.Sales.Calc" title:@"Calc" style:NULL];
        calcViewController = [[[CalcViewController alloc] initWithActivity:activity] autorelease];
        NSString* xmlFile = @"ESA_Sales_Calc_ActivityInstance";
        calcModelAdapter = [ModelAdapterSpecHelper modelAdapterWith:calcViewController xmlFileName:xmlFile];
    });

    describe(@"Object creation", ^{

        it(@"should allow instantiation with a view controller", ^{
            assertThat(calcModelAdapter, notNilValue());
        });

    });

    describe(@"Mapping UITextField controls to expanz_model_Field items in an ActivityInstance", ^{

        it(@"should return the Field corresponding to a UITextField", ^{
            Field* field = [calcModelAdapter fieldFor:calcViewController.Op1];
            assertThat(field, notNilValue());
            assertThat(field.fieldId, equalTo(@"Op1"));
        });

        it(@"should map the other way - return a UITextField for an expanz_model_field. ", ^{
            Field* field = [calcModelAdapter.activityInstance fieldWithId:@"Op2"];
            id textControl = [calcModelAdapter textInputControlFor:field];
            assertThat(textControl, notNilValue());
            LogDebug(@"Text Control: %@", textControl);
        });

    });
    
    describe(@"Mapping UITableView controls to expanz_model_DataSet items in an ActivityInstance", ^{

        __block CustomerViewController* customerViewController;
        __block ModelAdapter* customerModelAdapter;

        beforeEach(^{
            ActivityDefinition* activity =
                [[ActivityDefinition alloc] initWithName:@"ESA.Sales.Customer" title:@"Customer" style:NULL];
            customerViewController = [[[CustomerViewController alloc] initWithActivity:activity] autorelease];
            NSString* xmlFile = @"ESA_Sales_Customer_ActivityInstance";
            customerModelAdapter = [ModelAdapterSpecHelper modelAdapterWith:customerViewController xmlFileName:xmlFile];
        });
        
        it(@"Should return the expanz_model_DataSet that backs a UITableView.", ^{
            
            DataSet* dataSet = [customerModelAdapter dataSetFor:customerViewController.customersList];
            assertThat(dataSet, notNilValue());

        });

    });
    

    describe(@"Updating user interface controls with model values.", ^{

        it(@"should update each user interface control with the corresponding model value. ", ^{

            Field* op1 = [calcModelAdapter.activityInstance fieldWithId:@"Op1"];
            op1.value = @"9999";

            [calcModelAdapter updateUIControlsWithModelValues];
            assertThat(calcViewController.Op1.text, equalTo(@"9999"));

        });

    });



SPEC_END


