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

#import "OCMock.h"
#import "SpecHelper.h" 
#import "expanz_model_Activity.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_ui_ModelAdapter.h"
#import "expanz_ui_BasicCalculatorViewController.h"
#import "RXMLElement+ActivityInstance.h"



SPEC_BEGIN(ModelAdapterSpec)

__block BasicCalculatorViewController* controller;
__block ModelAdapter* modelAdapter; 

beforeEach(^{
    
    id injector = [OCMockObject niceMockForClass:[JSObjectionInjector class]]; 
    [JSObjection setGlobalInjector:injector];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"ActivityDetails" ofType:@"xml"]; 
    NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    RXMLElement* element = [RXMLElement elementFromXMLString:xmlString]; 
    Activity* activity = (Activity*) [[element child:@"ExecXResult.ESA.Activity"] asActivityInstance];
    controller = [[BasicCalculatorViewController alloc] initWithActivity:activity];
    assertThat(controller, notNilValue());
    assertThat(controller.view, notNilValue());
    
    filePath = [[NSBundle mainBundle] pathForResource:@"ActivityInstance" ofType:@"xml"]; 
    xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    element = [RXMLElement elementFromXMLString:xmlString]; 
    ActivityInstance* activityInstance = [[element child:@"ExecXResult.ESA.Activity"] asActivityInstance]; 
    [controller requestDidFinishWithActivityInstance:activityInstance];     
    modelAdapter = [[ModelAdapter alloc] initWithViewController:controller]; 
        
});

describe(@"Object creation", ^{

    it(@"should allow instantiation with a view controller", ^{
        assertThat(modelAdapter, notNilValue());                
    });
    
});

describe(@"Mapping UIControls to expanz_model_Field items in an ActivityInstance", ^{
    
    it(@"should return field corresponding to a UIControl", ^{ 
        Field* field = [modelAdapter fieldFor:controller.Op1]; 
        assertThat(field, notNilValue());
        assertThat(field.fieldId, equalTo(@"Op1"));        
    });
    
    it(@"should map the other way - return a UIControl for an expanz_model_field. ", ^{
        Field* field = [modelAdapter.activityInstance fieldWithId:@"Op2"]; 
        id textControl = [modelAdapter textControlFor:field]; 
        assertThat(textControl, notNilValue());
        LogDebug(@"Text Control: %@", textControl); 
    });
    
});

describe(@"Updating user interface controls with model values.", ^{

    it(@"should update each user interface control with the corresponding model value. ", ^{
        
        Field* op1 = [modelAdapter.activityInstance fieldWithId:@"Op1"]; 
        op1.value = @"9999"; 
        
        [modelAdapter updateUIControlsWithModelValues]; 
        assertThat(controller.Op1.text, equalTo(@"9999"));
        
    });
    
});





afterEach(^{
    [controller release]; 
    [modelAdapter release]; 
});


SPEC_END


