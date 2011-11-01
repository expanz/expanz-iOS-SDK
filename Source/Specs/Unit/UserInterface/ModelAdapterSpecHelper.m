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
#import "ModelAdapterSpecHelper.h"
#import "expanz_ui_ModelAdapter.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_model_ActivityInstance.h"
#import "RXMLElement.h"
#import "RXMLElement+ActivityInstance.h"
#import "OCMockObject.h"


@implementation ModelAdapterSpecHelper

+ (ModelAdapter*) modelAdapterWith:(ActivityInstanceViewController*)controller xmlFileName:(NSString*)fileName {

    //Controller will be asking this for collaborators, where for the purpose of the test nil is ok.
    id injector = [OCMockObject niceMockForClass:[JSObjectionInjector class]];
    [JSObjection setGlobalInjector:injector];

    assertThat(controller, notNilValue());
    assertThat(controller.view, notNilValue());
    NSString* filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"xml"];
    NSString* xmlString = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    ActivityInstance* activityInstance =
        [[[RXMLElement elementFromXMLString:xmlString] child:@"ExecXResult.ESA.Activity"] asActivityInstance];
    [controller requestDidFinishWithActivityInstance:activityInstance];
    return [[[ModelAdapter alloc] initWithViewController:controller] autorelease];
}


@end