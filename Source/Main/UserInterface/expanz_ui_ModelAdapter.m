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
#import "expanz_model_DataSet.h"

/* ================================================================================================================== */
@interface expanz_ui_ModelAdapter(private) 

- (void) cacheSelectorNamesForController:(ActivityInstanceViewController*)controller;
- (void) mapUITextFieldsForController:(ActivityInstanceViewController*)controller;
- (void) mapUILabelsForController:(ActivityInstanceViewController*)controller;
- (void) mapUITableViewsForController:(ActivityInstanceViewController*)controller;

@end

/* ================================================================================================================== */
@implementation expanz_ui_ModelAdapter


@synthesize activityInstance = _activityInstance; 

/* ================================================== Constructors ================================================== */
- (id) initWithViewController:(ActivityInstanceViewController*)viewController {
    self = [super init]; 
    if (self) {
        //weak reference.
        _activityInstance = viewController.activityInstance;
        _selectorNames = [[NSMutableArray alloc] init];
        _fieldMappings = [[NSMutableDictionary alloc] init];
        _labelMappings = [[NSMutableDictionary alloc] init];
        _dataSetMappings = [[NSMutableDictionary alloc] init];

        [self cacheSelectorNamesForController:viewController];
        [self mapUITextFieldsForController:viewController];
        [self mapUILabelsForController:viewController];
        [self mapUITableViewsForController:viewController];
    }
    return self;    
}

/* ================================================ Interface Methods =============================================== */
- (UITextField*) textInputControlFor:(expanz_model_Field*)field {
    return [_fieldMappings objectForKey:field.fieldId]; 
}

- (Field*) fieldFor:(UITextField*)control {
    NSArray* keys = [_fieldMappings allKeysForObject:control]; 
    return [_activityInstance fieldWithId:[keys objectAtIndex:0]]; 
}


- (UITableView*) dataViewControlFor:(expanz_model_DataSet*)dataSet {
    return nil;

}

- (expanz_model_DataSet*) dataSetFor:(UITableView*)dataControl {
    return [[[DataSet alloc] init] autorelease];
}


- (void) updateUIControlsWithModelValues {
    for (NSString* fieldId in [_fieldMappings allKeys]) {
        Field* field = [_activityInstance fieldWithId:fieldId]; 
        UITextField* textField = [_fieldMappings valueForKey:fieldId];        
        [textField setText: field.value];      
        [textField setEnabled:!field.isDisabled];
        UILabel* label = [_labelMappings valueForKey:fieldId];
        [label setText:field.label];
    }    
}


/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_selectorNames release];
    [_fieldMappings release];
    [_labelMappings release];
    [_dataSetMappings release];
    [super dealloc];    
}

/* ================================================== Private Methods =============================================== */
- (void) cacheSelectorNamesForController:(ActivityInstanceViewController*)controller {
    for (RTMethod* method in [[controller class] rt_methods]) {
        [_selectorNames addObject:[method selectorName]];
    }
}

#define kUIControlIsNilMessage @"The UITextField named '%@' is nil. Has the connection been made in Interface Builder?"
- (void) mapUITextFieldsForController:(ActivityInstanceViewController*)controller {
    for (NSString* selectorName in _selectorNames) {
        if ([_activityInstance fieldWithId:selectorName] != nil) {
            UITextField* textField = [controller performSelector:NSSelectorFromString(selectorName)];
            if (textField == nil) {
                [NSException raise:NSObjectNotAvailableException format:kUIControlIsNilMessage, selectorName];
            }
            LogDebug(@"Mapping field: '%@' to UITextField.", selectorName);
            [_fieldMappings setObject:textField forKey:selectorName];                 
        }            
    }                
}

- (void) mapUILabelsForController:(ActivityInstanceViewController*)controller {
    for (NSString* selectorName in _selectorNames) {
        if ([selectorName hasSuffix:@"Label"]) {
            NSString* fieldId = [selectorName substringToIndex:[selectorName rangeOfString:@"Label"].location];
            UILabel* uiLabel = [controller performSelector:NSSelectorFromString(selectorName)];
            if (uiLabel == nil) {
                LogInfo(@"***Warning*** UILabel for %@ is nil", selectorName);
            }
            LogDebug(@"Mapping label: '%@' to UILabel.", selectorName);
            [_labelMappings setObject:uiLabel forKey:fieldId];
        }
    }       
}

- (void) mapUITableViewsForController:(ActivityInstanceViewController*)controller {
    for (NSString* selectorName in _selectorNames) {
        //DataSet* dataSet = _activityInstance
    }


    
}


@end
