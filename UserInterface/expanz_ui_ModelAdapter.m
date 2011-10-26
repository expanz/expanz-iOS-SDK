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

#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_ui_ModelAdapter.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "MARTNSObject.h"
#import "RTMethod.h"

#define kUIControlIsNilMessage @"The UI control named '%@' is nil. Has the connection been made in Interface Builder?"

/* ================================================================================================================== */
@implementation expanz_ui_ModelAdapter


@synthesize activityInstance = _activityInstance; 

/* ================================================== Constructors ================================================== */

- (id) initWithViewController:(ActivityInstanceViewController*)viewController {
    self = [super init]; 
    if (self) {
        _activityInstance = [viewController.activityInstance retain];
        _fieldMappings = [[NSMutableDictionary alloc] init];
        NSArray* classMethods = [[viewController class] rt_methods]; 
        for (RTMethod* method in classMethods) {
            NSString* selectorName = [method selectorName];            
            if ([_activityInstance fieldWithId:selectorName]) {            
                UIControl* uiControl; 
                [method returnValue: &uiControl sendToTarget: viewController]; 
                if (uiControl == nil) {
                    [NSException raise:NSObjectNotAvailableException format:kUIControlIsNilMessage, selectorName]; 
                }
                LogDebug(@"Mapping field: '%@' to UIControl.", selectorName);
                [_fieldMappings setObject:uiControl forKey:selectorName];                 
            }            
        }                
    }
    return self;    
}

/* ================================================ Interface Methods =============================================== */

- (UIControl*) textControlFor:(Field*)field {
    return [_fieldMappings objectForKey:field.fieldId]; 
}

- (Field*) fieldFor:(UIControl*)control {
    NSArray* keys = [_fieldMappings allKeysForObject:control]; 
    return [_activityInstance fieldWithId:[keys objectAtIndex:0]]; 
}

- (void) updateUIControlsWithModelValues {
    for (NSString* fieldId in [_fieldMappings allKeys]) {
        Field* field = [_activityInstance fieldWithId:fieldId]; 
        UITextField* textField = [_fieldMappings valueForKey:fieldId];         
        [textField setText: field.value];      
        [textField setEnabled:!field.isDisabled];
    }    
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_activityInstance release];
    [_fieldMappings release]; 
    [super dealloc];    
}


@end
