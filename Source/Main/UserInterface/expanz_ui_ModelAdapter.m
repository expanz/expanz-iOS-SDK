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
#import "expanz_model_BaseCell.h"
#import "expanz_model_ImageCell.h"

/* ================================================================================================================== */
@interface expanz_ui_ModelAdapter (private)

- (void) raiseErrorForNonMappedControl:(NSString*)controlName typeName:(NSString*)typeName;

- (void) cacheSelectorNamesForController:(ActivityInstanceViewController*)controller;

- (void) mapFieldsForController:(ActivityInstanceViewController*)controller;

- (void) mapLabelsForController:(ActivityInstanceViewController*)controller;

- (void) mapUITableViewsForController:(ActivityInstanceViewController*)controller;

@end

/* ================================================================================================================== */
@implementation expanz_ui_ModelAdapter


@synthesize activityInstance = _activityInstance;

/* ================================================== Constructors ================================================== */
- (id) initWithViewController:(ActivityInstanceViewController*)viewController {
    self = [super init];
    if (self) {
        _activityInstance = viewController.activityInstance;
        _selectorNames = [[NSMutableArray alloc] init];
        _textFieldMappings = [[NSMutableDictionary alloc] init];
        _imageFieldMappings = [[NSMutableDictionary alloc] init];
        _labelMappings = [[NSMutableDictionary alloc] init];
        _dataSetMappings = [[NSMutableDictionary alloc] init];

        [self cacheSelectorNamesForController:viewController];
        [self mapFieldsForController:viewController];
        [self mapLabelsForController:viewController];
        [self mapUITableViewsForController:viewController];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
#pragma mark Mapping UI controls to model

- (UITextField*) textInputControlFor:(expanz_model_Field*)field {
    return [_textFieldMappings objectForKey:field.fieldId];
}

- (Field*) fieldFor:(UITextField*)control {
    NSArray* keys = [_textFieldMappings allKeysForObject:control];
    return [_activityInstance fieldWithId:[keys objectAtIndex:0]];
}


- (UITableView*) dataViewControlFor:(expanz_model_DataSet*)dataSet {
    return [_dataSetMappings objectForKey:dataSet.dataId];
}

- (expanz_model_DataSet*) dataSetFor:(UITableView*)dataControl {
    NSArray* keys = [_dataSetMappings allKeysForObject:dataControl];
    return [_activityInstance dataSetWithId:[keys objectAtIndex:0]];
}

/* ================================================================================================================== */
#pragma mark Synchronizing UI controls

- (void) updateUIControlsWithModelValues {
    [self updateLabelsWithModelValues];
    [self updateUITextFieldsWithModelValues];
    [self updateUIImagesWithModelValues];
    [self updateDataGridsWithModelValues];
}

- (void) updateLabelsWithModelValues {
    for (NSString* fieldId in [_labelMappings allKeys]) {
        UILabel* label = [_labelMappings valueForKey:fieldId];
        Field* field = [_activityInstance fieldWithId:fieldId];
        [label setText:field.label];
    }
}

- (void) updateUITextFieldsWithModelValues {
    for (NSString* fieldId in [_textFieldMappings allKeys]) {
        Field* field = [_activityInstance fieldWithId:fieldId];
        UITextField* textField = [_textFieldMappings valueForKey:fieldId];
        [textField setText:field.value];
        [textField setEnabled:!field.isDisabled];
    }
}

- (void) updateUIImagesWithModelValues {

}

- (void) updateDataGridsWithModelValues {
    for (UITableView* tableView in [_dataSetMappings allValues]) {
        [tableView reloadData];
        [tableView setNeedsLayout];
    }
}

- (void) startObserving:(expanz_model_ImageCell*)cell {
    [cell addObserver:self forKeyPath:@"image" options:0 context:nil];
}


/* ================================================== Utility Methods =============================================== */
#pragma mark Utility Methods

- (void) dealloc {
    [_selectorNames release];
    [_textFieldMappings release];
    [_imageFieldMappings release];
    [_labelMappings release];
    [_dataSetMappings release];
    [super dealloc];
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object change:(NSDictionary*)change
                        context:(void*)context {

    [self updateDataGridsWithModelValues];
}

/* ================================================== Private Methods =============================================== */
#pragma mark Private Methods

- (void) cacheSelectorNamesForController:(ActivityInstanceViewController*)controller {
    for (RTMethod* method in [[controller class] rt_methods]) {
        [_selectorNames addObject:[method selectorName]];
    }
}

- (void) mapFieldsForController:(ActivityInstanceViewController*)controller {
    for (NSString* selectorName in _selectorNames) {
        Field* field = [_activityInstance fieldWithId:selectorName];
        if (field != nil) {
            if (field.datatype == ExpanzDataTypeString || field.datatype == ExpanzDataTypeNumber) {
                UITextField* textField = [controller performSelector:NSSelectorFromString(selectorName)];
                if (textField == nil) {
                    [self raiseErrorForNonMappedControl:selectorName typeName:@"UITextField"];
                }
                [_textFieldMappings setObject:textField forKey:selectorName];
            }
            else if (field.datatype == ExpanzDataTypeImage) {
                LogDebug(@"Mapping image. . . . ");
                UIImageView* imageView = [controller performSelector:NSSelectorFromString(selectorName)];
                if (imageView == nil) {
                    [self raiseErrorForNonMappedControl:selectorName typeName:@"UIImageView"];
                }
                [_imageFieldMappings setObject:imageView forKey:selectorName];
                break;
            }
        }
    }
}

- (void) mapLabelsForController:(ActivityInstanceViewController*)controller {
    for (NSString* selectorName in _selectorNames) {
        if ([selectorName hasSuffix:@"Label"]) {
            NSString* fieldId = [selectorName substringToIndex:[selectorName rangeOfString:@"Label"].location];
            UILabel* uiLabel = [controller performSelector:NSSelectorFromString(selectorName)];
            if (uiLabel == nil) {
                LogInfo(@"***Warning*** UILabel for %@ is nil", selectorName);
            }
            else {
                [_labelMappings setObject:uiLabel forKey:fieldId];
            }
        }
    }
}

- (void) mapUITableViewsForController:(ActivityInstanceViewController*)controller {
    for (NSString* selectorName in _selectorNames) {
        if ([_activityInstance dataSetWithId:selectorName] != nil) {
            UITableView* tableView = [controller performSelector:NSSelectorFromString(selectorName)];
            if (tableView == nil) {
                [self raiseErrorForNonMappedControl:selectorName typeName:@"UITableView"];
            }
            [_dataSetMappings setObject:tableView forKey:selectorName];
        }
    }
}

- (void) raiseErrorForNonMappedControl:(NSString*)controlName typeName:(NSString*)typeName {
    [NSException raise:NSObjectNotAvailableException
                format:@"The %@ named '%@' is nil. Has the connection been made in Interface Builder?", typeName,
                       controlName];
}


@end