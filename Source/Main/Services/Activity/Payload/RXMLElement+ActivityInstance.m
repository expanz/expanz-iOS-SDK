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
#import "../../../Model/expanz_model_DataSet.h"


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

- (Message*) asMessage {
    if (![self.tag isEqualToString:@"Message"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Message."];
    }
    MessageType
        messageType = [[self attribute:@"type"] isEqualToString:@"Warning"] ? MessageTypeWarning : MessageTypeError;
    return [[[Message alloc] initWithMessageType:messageType content:[self text]] autorelease];
}

- (DataSet*) asData {
    DataSet* dataSet =
        [[[DataSet alloc] initWithDataId:[self attribute:@"id"] source:[self attribute:@"source"]] autorelease];
    return dataSet;


}


@end
