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

#import "RXMLElement+ActivityInstance.h"
#import "expanz_ios_SdkExceptions.h"
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_model_Message.h"
#import "expanz_model_GridData.h"
#import "expanz_model_Column.h"
#import "expanz_model_Row.h"
#import "expanz_model_DataBuilder.h"
#import "expanz_model_Folder.h"
#import "expanz_model_File.h"
#import "expanz_model_FileResource.h"


@implementation RXMLElement (ActivityInstance)

- (ActivityInstance*) asActivityInstance {
    if (![self.tag isEqualToString:@"Activity"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not an Activity."];
    }
    ActivityInstance* activityInstance = [[ActivityInstance alloc]
        initWithTitle:[self attribute:@"title"] handle:[self attribute:@"activityHandle"]
         persistentId:[self attribute:@"persistentId"]];

    [self iterate:@"*" with:^(RXMLElement* e) {

        if ([e.tag isEqualToString:@"Field"]) {
            [activityInstance addField:[e asField]];
        }

        else if ([e.tag isEqualToString:@"Messages"]) {
            [e iterate:@"*" with:^(RXMLElement* messageElement) {
                [activityInstance addMessage:[messageElement asMessage]];
            }];
        }

        else if ([e.tag isEqualToString:@"Data"]) {
            [activityInstance addData:[e asData]];
        }
    }];

    return activityInstance;
}

/* ================================================================================================================== */
- (Field*) asField {
    if (![self.tag isEqualToString:@"Field"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Field."];
    }
    NSString* fieldId = [self attribute:@"id"];
    BOOL nullable = [[self attribute:@"nullable"] boolValue];
    NSString* defaultValue = [self attribute:@"null"];
    ExpanzDataType datatype = [[self attribute:@"datatype"] asExpanzDataType];
    NSString* label = [self attribute:@"label"];
    NSString* hint = [self attribute:@"hint"];

    Field* field = [[Field alloc]
        initWithFieldId:fieldId nullable:nullable defaultValue:defaultValue dataType:datatype label:label hint:hint];

    switch (field.datatype) {
        case ExpanzDataTypeString:
        case ExpanzDataTypeNumber:
        case ExpanzDataTypeBool:
        case ExpanzDataTypeNull:
        case ExpanzDataTypeDate:
        case ExpanzDataTypeDateTime:
            [field setValue:[self attribute:@"value"]];
            break;

        case ExpanzDataTypeImage:
            [field setValue:[self attribute:@"url"]];
            break;
    }

    [field setDisabled:[[self attribute:@"disabled"] boolValue]];
    return field;
}

/* ================================================================================================================== */
- (Message*) asMessage {
    if (![self.tag isEqualToString:@"Message"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Message."];
    }
    MessageType
        messageType = [[self attribute:@"type"] isEqualToString:@"Warning"] ? MessageTypeWarning : MessageTypeError;
    return [[Message alloc] initWithMessageType:messageType content:[self text]];
}

/* ================================================================================================================== */
#pragma mark DataSet and DataSet child elements.
- (AbstractData*) asData {
    if (![self.tag isEqualToString:@"Data"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not Data."];
    }
    DataBuilder* dataBuilder =
        [[DataBuilder alloc] initWithDataId:[self attribute:@"id"] source:[self attribute:@"source"]];

    [self iterate:@"*" with:^(RXMLElement* e) {

        if ([e.tag isEqualToString:@"Columns"]) {
            [e iterate:@"*" with:^(RXMLElement* columnElement) {
                [dataBuilder addColumn:[columnElement asColumn]];
            }];
        }

        else if ([e.tag isEqualToString:@"Rows"]) {
            [e iterate:@"*" with:^(RXMLElement* rowElement) {
                [dataBuilder addRow:[rowElement asRow]];
            }];
        }

        else if ([e.tag isEqualToString:@"Folder"]) {
            [dataBuilder addFolder:[e asFolder]];
        }
    }];

    return [dataBuilder build];
}

- (Column*) asColumn {
    if (![self.tag isEqualToString:@"Column"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Column."];
    }
    NSString* columnId = [self attribute:@"id"];
    NSString* field = [self attribute:@"field"];
    NSString* label = [self attribute:@"label"];
    ExpanzDataType dataType = [[self attribute:@"datatype"] asExpanzDataType];
    NSInteger width = [[self attribute:@"width"] integerValue];

    Column* column =
        [[Column alloc] initWithColumnId:columnId field:field label:label dataType:dataType width:width];

    return column;
}

- (Row*) asRow {
    if (![self.tag isEqualToString:@"Row"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Row."];
    }
    Row* row = [[Row alloc] initWithRowId:[self attribute:@"id"] type:[self attribute:@"Type"]];

    [self iterate:@"*" with:^(RXMLElement* e) {
        if ([e.tag isEqualToString:@"Cell"]) {
            [row addCellDefinitionWithId:[e attribute:@"id"] data:[e text]];
        }
    }];

    return row;
}

- (expanz_model_Folder*) asFolder {
    if (![self.tag isEqualToString:@"Folder"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Folder."];
    }

    NSString* id = [self attribute:@"id"];
    NSString* title = [self attribute:@"title"];
    NSString* hint = [self attribute:@"hint"];
    NSString* buttonTitle = [self attribute:@"title"];
    NSString* sequence = [self attribute:@"sequence"];

    Folder* folder =
        [[Folder alloc] initWithFolderId:id title:title hint:hint buttonTitle:buttonTitle sequence:sequence];

    [self iterate:@"*" with:^(RXMLElement* e) {
        if ([e.tag isEqualToString:@"File"]) {
            [folder addFile:[e asFile]];
        }
    }];

    return folder;
}

- (expanz_model_File*) asFile {
    if (![self.tag isEqualToString:@"File"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a File."];
    }

    NSString* id = [self attribute:@"id"];
    NSString* title = [self attribute:@"title"];
    NSString* hint = [self attribute:@"hint"];
    NSString* fileName = [self attribute:@"filename"];
    NSString* sequence = [self attribute:@"sequence"];
    NSString* type = [self attribute:@"type"];
    NSString* field = [self attribute:@"field"];

    File* file = [[File alloc]
        initWithFileId:id title:title hint:hint fileName:fileName sequence:sequence type:type field:field];

    return file;

}


@end
