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
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_model_Message.h"
#import "expanz_model_DataSet.h"
#import "expanz_model_Column.h"
#import "expanz_model_Row.h"
#import "expanz_model_TextCell.h"


@implementation RXMLElement (ActivityInstance)

- (ActivityInstance*) asActivityInstance {
    if (![self.tag isEqualToString:@"Activity"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not an Activity."];
    }
    ActivityInstance* activityInstance = [[[ActivityInstance alloc]
        initWithTitle:[self attribute:@"title"] handle:[self attribute:@"activityHandle"]
         persistentId:[self attribute:@"persistentId"]] autorelease];

    [self iterate:@"*" with:^(RXMLElement* e) {

        if ([e.tag isEqualToString:@"Field"]) {
            [activityInstance addField:[e asField]];
        }

        if ([e.tag isEqualToString:@"Messages"]) {
            [e iterate:@"*" with:^(RXMLElement* messageElement) {
                [activityInstance addMessage:[messageElement asMessage]];
            }];
        }

        if ([e.tag isEqualToString:@"Data"]) {
            [activityInstance addDataSet:[e asData]];
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
    NSString* datatype = [self attribute:@"datatype"];
    NSString* label = [self attribute:@"label"];
    NSString* hint = [self attribute:@"hint"];

    Field* field = [[[Field alloc]
        initWithFieldId:fieldId nullable:nullable defaultValue:defaultValue dataType:datatype label:label hint:hint]
        autorelease];
    [field setValue:[self attribute:@"value"]];
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
    return [[[Message alloc] initWithMessageType:messageType content:[self text]] autorelease];
}

/* ================================================================================================================== */
#pragma mark DataSet and DataSet child elements.
- (DataSet*) asData {
    if (![self.tag isEqualToString:@"Data"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not Data."];
    }
    DataSet* dataSet =
        [[[DataSet alloc] initWithDataId:[self attribute:@"id"] source:[self attribute:@"source"]] autorelease];

    [self iterate:@"*" with:^(RXMLElement* e) {

        if ([e.tag isEqualToString:@"Columns"]) {
            [e iterate:@"*" with:^(RXMLElement* columnElement) {
                [dataSet addColumn:[columnElement asColumn]];
            }];
        }

        if ([e.tag isEqualToString:@"Rows"]) {
            [e iterate:@"*" with:^(RXMLElement* rowElement) {
                [dataSet addRow:[rowElement asRow]];
            }];
        }
    }];

    return dataSet;
}

- (Column*) asColumn {
    if (![self.tag isEqualToString:@"Column"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Column."];
    }
    NSString* columnId = [self attribute:@"id"];
    NSString* field = [self attribute:@"field"];
    NSString* label = [self attribute:@"label"];
    ExpanzDataType dataType = ExpanzDataTypeFromString([self attribute:@"datatype"]);
    NSInteger width = [[self attribute:@"width"] integerValue];

    Column* column =
        [[[Column alloc] initWithColumnId:columnId field:field label:label dataType:dataType width:width] autorelease];

    return column;
}

- (Row*) asRow {
    if (![self.tag isEqualToString:@"Row"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Row."];
    }
    Row* row = [[[Row alloc] initWithRowId:[self attribute:@"id"] type:[self attribute:@"Type"]] autorelease];

    [self iterate:@"*" with:^(RXMLElement* e) {
        if ([e.tag isEqualToString:@"Cell"]) {
            [row addCellDefinitionWithId:[e attribute:@"id"] data:[e text]];
        }
    }];

    return row;
}

@end
