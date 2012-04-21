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

#import <objc/message.h>
#import <LRResty/LRResty.h>
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_FieldInstance.h"
#import "expanz_model_menuItem.h"
#import "expanz_model_GridData.h"
#import "expanz_ui_GridDataRenderer.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "expanz_ui_ModelAdapter.h"
#import "UIView+ModelAdapter.h"
#import "expanz_model_AbstractData+DataRenderer.h"

/* ================================================================================================================== */
@interface expanz_ui_ModelAdapter (private)

- (void) mapModelFieldsToUITextFields;

- (void) mapModelFieldsToUILabels;

- (void) mapModelFieldsToUIImages;

- (void) mapModelFieldsToUITableViews;

- (void) makeReadOnlyControlFor:(UITextField*)textField andSetText:(NSString*)text;

- (void) destroyReadOnlyControlFor:(UITextField*)textField;

@end

/* ================================================================================================================== */
@implementation expanz_ui_ModelAdapter


@synthesize activityName = _activityName;
@synthesize activityInstance = _activityInstance;
@synthesize controller = _controller;

/* ================================================== Initializers ================================================== */
- (id) initWithViewController:(ActivityInstanceViewController*)viewController {
    self = [super init];
    if (self) {
        _activityName = [viewController.menuItem.activityId copy];
        _activityInstance = viewController.activityInstance;
        _controller = viewController;
        _propertyNames = viewController.propertyNames;

        [self mapModelFieldsToUITextFields];
        [self mapModelFieldsToUILabels];
        [self mapModelFieldsToUITableViews];
        [self mapModelFieldsToUIImages];

    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
#pragma mark Mapping UI controls to model

- (UITextField*) textFieldFor:(expanz_model_FieldInstance*)field {
    return [_textFieldMappings objectForKey:field.fieldId];
}

- (FieldInstance*) fieldFor:(UIView*)uiView {
    NSString* fieldId = [uiView fieldIdInModelAdapter:self];
    return [_activityInstance fieldWithId:fieldId];
}

- (UITableView*) tableViewFor:(expanz_model_GridData*)dataSet {
    return [_tableViewMappings objectForKey:dataSet.dataId];
}

- (UIImageView*) imageViewFor:(UIButton*)editButton {
    return [_imageButtonMappings objectForKey:[NSValue valueWithPointer:(__bridge void*) editButton]];
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
        FieldInstance* field = [_activityInstance fieldWithId:fieldId];
        [label setText:field.label];
    }
}

- (void) updateUITextFieldsWithModelValues {
    for (NSString* fieldId in [_textFieldMappings allKeys]) {
        FieldInstance* field = [_activityInstance fieldWithId:fieldId];
        UITextField* textField = [_textFieldMappings valueForKey:fieldId];

        if ([field isDisabled]) {
            [self makeReadOnlyControlFor:textField andSetText:field.value];
        }
        else {
            [self destroyReadOnlyControlFor:textField];
            [textField setText:field.value];
            [textField setHidden:NO];
        }
    }
}

- (void) updateUIImagesWithModelValues {
    LogDebug(@"Updating images . . . . ");
    for (NSString* fieldId in [_imageFieldMappings allKeys]) {
        FieldInstance* field = [_activityInstance fieldWithId:fieldId];
        LogDebug(@"Field: %@", field);
        LogDebug(@"Image url: %@", field.value);

        [[LRResty client] get:field.value withBlock:^(LRRestyResponse* response) {
            LogDebug(@"In completion block");
            if (response.status == 200) {
                UIImageView* imageView = [_imageFieldMappings valueForKey:fieldId];
                imageView.image = [UIImage imageWithData:[response responseData]];
            }
            else {
                //TODO: Handle this?
                LogError(@"Can't download the image: %@", field.value);
            }
        }];
    }
}

- (void) updateDataGridsWithModelValues {
    for (UITableView* tableView in [_tableViewMappings allValues]) {
        [tableView reloadData];
        [tableView setNeedsLayout];
    }
}


/* ================================================== Private Methods =============================================== */
#pragma mark Private Methods

#define kNoMappingWarning @"*** Warning *** %@ for %@ is nil. Has the connection been made in Interface Builder?"


- (void) mapModelFieldsToUITextFields {

    _textFieldMappings = [[NSMutableDictionary alloc] init];
    _readOnlyTextFields = [[NSMutableDictionary alloc] init];

    for (NSString* propertyName in _propertyNames) {
        FieldInstance* field = [_activityInstance fieldWithId:propertyName];

        if (field != nil) {
            UIControl* uiControl = objc_msgSend(_controller, NSSelectorFromString(propertyName));
            if (field.datatype == ExpanzDataTypeString || field.datatype == ExpanzDataTypeNumber) {
                UITextField* textField = (UITextField*) uiControl;
                if (textField == nil) {
                    LogInfo(kNoMappingWarning, @"UITextField", field.fieldId);
                }
                else {
                    [_textFieldMappings setObject:textField forKey:propertyName];
                    id<UITextFieldDelegate> delegate = _controller;
                    [textField setDelegate:delegate];
                }
            }
        }
    }
}

- (void) mapModelFieldsToUIImages {
    _imageFieldMappings = [[NSMutableDictionary alloc] init];
    _imageButtonMappings = [[NSMutableDictionary alloc] init];
    for (NSString* propertyName in _propertyNames) {
        FieldInstance* field = [_activityInstance fieldWithId:propertyName];

        if (field != nil) {
            UIControl* uiControl = objc_msgSend(_controller, NSSelectorFromString(propertyName));
            if (field.datatype == ExpanzDataTypeImage) {
                UIImageView* imageView = (UIImageView*) uiControl;
                if (imageView == nil) {
                    LogInfo(kNoMappingWarning, @"UIImageView", field.fieldId);
                }
                else {
                    [_imageFieldMappings setObject:imageView forKey:propertyName];
                    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
                    button.frame = imageView.frame;
                    [button addTarget:_controller action:@selector(willCommenceEditForImageView:)
                            forControlEvents:UIControlEventTouchUpInside];
                    [_controller.view addSubview:button];
                    [_imageButtonMappings
                            setObject:imageView forKey:[NSValue valueWithPointer:(__bridge void*) button]];
                }
            }
        }
    }
}

- (void) mapModelFieldsToUILabels {
    _labelMappings = [[NSMutableDictionary alloc] init];
    for (NSString* selectorName in _propertyNames) {
        if ([selectorName hasSuffix:@"Label"]) {
            NSString* fieldId = [selectorName substringToIndex:[selectorName rangeOfString:@"Label"].location];
            UILabel* uiLabel = objc_msgSend(_controller, NSSelectorFromString(selectorName));
            if (uiLabel == nil) {
                LogInfo(kNoMappingWarning, @"UILabel", selectorName);
            }
            else {
                [_labelMappings setObject:uiLabel forKey:fieldId];
            }
        }
    }
}

- (void) mapModelFieldsToUITableViews {
    _tableViewMappings = [[NSMutableDictionary alloc] init];
    _dataRenderers = [[NSMutableArray alloc] init];

    for (NSString* selectorName in _propertyNames) {
        if ([_activityInstance dataWithId:selectorName] != nil) {
            UITableView* tableView = objc_msgSend(_controller, NSSelectorFromString(selectorName));
            if (tableView == nil) {
                LogInfo(kNoMappingWarning, @"UITableView", selectorName);
            }
            else {
                [_tableViewMappings setObject:tableView forKey:selectorName];

                AbstractData* data = [_activityInstance dataWithId:selectorName];
                AbstractDataRenderer* renderer = [data withDataRendererFor:tableView activityName:_activityName];
                [renderer makeSearchableWith:_controller.searchBar controller:_controller];
                [_dataRenderers addObject:renderer];
                [tableView setDataSource:renderer];
                [tableView setDelegate:renderer];
            }
        }
    }
}

- (void) makeReadOnlyControlFor:(UITextField*)textField andSetText:(NSString*)text {
    NSValue* labelKey = [NSValue valueWithPointer:(__bridge void*) textField];
    UILabel* label = [_readOnlyTextFields objectForKey:labelKey];
    if (label == nil) {
        UILabel* label = [[UILabel alloc] init];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setFrame:UIEdgeInsetsInsetRect([textField frame], UIEdgeInsetsMake(0, 3, 0, 3))];
        [label setFont:[textField font]];
        [label setTextColor:[textField textColor]];
        [label setText:text];


        [_controller.view addSubview:label];
        [_readOnlyTextFields setObject:label forKey:labelKey];
        [textField setHidden:YES];
    }
}

- (void) destroyReadOnlyControlFor:(UITextField*)textField {
    NSValue* labelKey = [NSValue valueWithPointer:(__bridge void*) textField];
    UILabel* label = [_readOnlyTextFields objectForKey:labelKey];
    if (label != nil) {
        LogDebug(@"Destroying read only label for text field");
        [label removeFromSuperview];
        [_readOnlyTextFields removeObjectForKey:labelKey];
        [textField setHidden:NO];
    }
}


@end