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
#import "expanz_iOS_SDKExceptions.h"


@implementation RXMLElement (ActivityInstance)

- (ActivityInstance*) asActivityInstance {
    if (![self.tag isEqualToString:@"Activity"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not an Activity."];
    }
    ActivityInstance* activityInstance = [[[ActivityInstance alloc] initWithTitle:[self attribute:@"title"] 
                                        handle:[self attribute:@"activityHandle"] 
                                        persistentId:[self attribute:@"persistentId"]] autorelease]; 
    
    [self iterate:@"*" with: ^(RXMLElement* e) {
        
        if ([e.tag isEqualToString:@"Field"]) {
            [activityInstance addField:[e asField]];
        }        
    }];            
    
    return activityInstance;
}

- (Field*) asField {
    if (![self.tag isEqualToString:@"Field"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Field."];
    }
    NSString* fieldId = [self attribute:@"id"]; 
    NSString* nullableAttr = [self attribute:@"nullable"];    
    BOOL nullable = (nullableAttr != nil && ![nullableAttr isEqualToString:@"0"]);
    NSString* defaultValue = [self attribute:@"null"]; 
    NSString* datatype = [self attribute:@"datatype"];
    
    
    return [[[Field alloc] initWithFieldId:fieldId nullable:nullable defaultValue:defaultValue dataType:datatype] 
            autorelease];    
}

@end
