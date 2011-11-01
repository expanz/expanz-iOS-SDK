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
#import "RXMLElement+ActivityInstance.h"
#import "OCMockObject.h"
#import "ESA_Sales_CustomerViewController.h"

/* ================================================================================================================== */
//Stub a navigation controller - expected to be there by UITableView+DataPublication
@interface CedarApplicationDelegate
@end
@implementation CedarApplicationDelegate(private)
- (UINavigationController*) navigationController {
    return nil;
}
@end
/* ================================================================================================================== */

SPEC_BEGIN(ModelAdapterSpec)

    __block CalcViewController* calcViewController;
    __block ModelAdapter* calcModelAdapter;

    __block CustomerViewController* customerViewController;
    __block ModelAdapter* customerModelAdapter;

    beforeEach(^{

        id injector = [OCMockObject niceMockForClass:[JSObjectionInjector class]];
        [JSObjection setGlobalInjector:injector];


        /* ========================================================================================================== */
        //Setup calc model adapter.

        NSString* calcFilePath;
        NSString* calcXmlString;
        ActivityDefinition* calcActivity;

        calcActivity = [[ActivityDefinition alloc] initWithName:@"ESA.Sales.Calc" title:@"Basic Calculator" style:NULL];
        calcViewController = [[[CalcViewController alloc] initWithActivity:calcActivity] autorelease];
        assertThat(calcViewController, notNilValue());
        assertThat(calcViewController.view, notNilValue());
        calcFilePath = [[NSBundle mainBundle] pathForResource:@"ESA_Sales_Calc_ActivityInstance" ofType:@"xml"];
        calcXmlString = [[NSString alloc] initWithContentsOfFile:calcFilePath encoding:NSUTF8StringEncoding error:nil];
        ActivityInstance* activityInstance =
            [[[RXMLElement elementFromXMLString:calcXmlString] child:@"ExecXResult.ESA.Activity"] asActivityInstance];
        [calcViewController requestDidFinishWithActivityInstance:activityInstance];
        calcModelAdapter = [[[ModelAdapter alloc] initWithViewController:calcViewController] autorelease];

        /* ========================================================================================================== */
        //Setup customer model adapter.

        NSString* customerFilePath;
        NSString* customerXmlString;
        ActivityDefinition* customerActivity;

        customerActivity = [[ActivityDefinition alloc] initWithName:@"ESA.Sales.Customer" title:@"Customer" style:NULL];
        customerViewController = [[[CustomerViewController alloc] initWithActivity:customerActivity] autorelease];
        assertThat(customerViewController, notNilValue());
        assertThat(customerViewController.view, notNilValue());
        customerFilePath = [[NSBundle mainBundle] pathForResource:@"ESA_Sales_Customer_ActivityInstance" ofType:@"xml"];
        customerXmlString =
            [[NSString alloc] initWithContentsOfFile:customerFilePath encoding:NSUTF8StringEncoding error:nil];
        ActivityInstance* customerActivityInstance =
            [[[RXMLElement elementFromXMLString:customerXmlString] child:@"ExecXResult.ESA.Activity"] asActivityInstance];
        [customerViewController requestDidFinishWithActivityInstance:customerActivityInstance];
        customerModelAdapter = [[[ModelAdapter alloc] initWithViewController:customerViewController] autorelease];

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


    describe(@"Updating user interface controls with model values.", ^{

        it(@"should update each user interface control with the corresponding model value. ", ^{

            Field* op1 = [calcModelAdapter.activityInstance fieldWithId:@"Op1"];
            op1.value = @"9999";

            [calcModelAdapter updateUIControlsWithModelValues];
            assertThat(calcViewController.Op1.text, equalTo(@"9999"));

        });

    });



    SPEC_END


