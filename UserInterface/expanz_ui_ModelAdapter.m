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


/* ================================================================================================================== */
@implementation expanz_ui_ModelAdapter


@synthesize activityInstance = _activityInstance; 

/* ================================================== Constructors ================================================== */

- (id) initWithViewController:(ActivityInstanceViewController*)viewController {
    self = [super init]; 
    if (self) {
        _activityInstance = [viewController.activityInstance retain];
        _mappings = [[NSMutableDictionary alloc] init];
        NSArray* classMethods = [[viewController class] rt_methods]; 
        for (RTMethod* method in classMethods) {
            NSString* selectorName = [method selectorName];
            if ([selectorName hasSuffix:@"Field"]) {
                NSString* fieldId = [selectorName substringToIndex:[selectorName rangeOfString:@"Field"].location]; 
                UIControl* uiComponent; 
                [method returnValue: &uiComponent sendToTarget: viewController]; 
                LogDebug(@"Mapping field: '%@' to UIControl.", fieldId);
                [_mappings setObject:uiComponent forKey:fieldId];                 
            }            
        }                
    }
    return self;    
}

/* ================================================ Interface Methods =============================================== */

- (UIControl*) textControlFor:(Field*)field {
    return [_mappings objectForKey:field.fieldId]; 
}

- (Field*) fieldFor:(UIControl*)control {
    NSArray* keys = [_mappings allKeysForObject:control]; 
    return [_activityInstance fieldWithId:[keys objectAtIndex:0]]; 
}

- (void) updateUIControlsFromModelValues {
    for (NSString* fieldId in [_mappings allKeys]) {
        Field* field = [_activityInstance fieldWithId:fieldId]; 
        id textControl = [_mappings valueForKey:fieldId];         
        [textControl setText: field.value];         
    }    
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_activityInstance release];
    [_mappings release]; 
    [super dealloc];    
}


@end
