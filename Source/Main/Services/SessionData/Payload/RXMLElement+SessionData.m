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

#import "RXMLElement+SessionData.h"
#import "expanz_model_ActivityDefinition.h"
#import "expanz_model_Menu.h"
#import "expanz_model_ProcessArea.h"
#import "expanz_model_UserRole.h"

@implementation RXMLElement (SessionData)


/* ================================================ Interface Methods =============================================== */


- (Menu*) asMenu {
    if (![self.tag isEqualToString:@"Menu"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a Menu."];
    }

    BOOL hasWorkFlowTrays = [[self attribute:@"hasWorkflowTrays"] boolValue];
    BOOL canChangeCompanyRoles = [[self attribute:@"canChangeCompanyRole"] boolValue];

    Menu* menu = [[[Menu alloc] initWithHasWorkFlowTrays:hasWorkFlowTrays
                                    canChangeCompanyRole:canChangeCompanyRoles] autorelease];

    [self iterate:@"*" with:^(RXMLElement* e) {

        if ([e.tag isEqualToString:@"ProcessArea"]) {
            [menu addProcessArea:[e asProcessArea]];
        }

        else if ([e.tag isEqualToString:@"Roles"]) {
            [e iterate:@"*" with:^(RXMLElement* roleElement) {
                [menu addUserRole:[roleElement asUserRole]];
            }];

        }
    }];
    return menu;

}

- (ProcessArea*) asProcessArea {
    if (![self.tag isEqualToString:@"ProcessArea"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a ProcessArea."];
    }
    ProcessArea* processArea = [[[ProcessArea alloc] initWithProcessId:[self attribute:@"id"]
                                                              andTitle:[self attribute:@"title"]] autorelease];
    [self iterate:@"*" with:^(RXMLElement* e) {        
        [processArea addActivityDefinition:[e asActivityDefinition]];
    }];
    return processArea;
}

- (ActivityDefinition*) asActivityDefinition {
    return [[[ActivityDefinition alloc] initWithName:[self attribute:@"name"] title:[self attribute:@"title"] 
                                              style:[self attribute:@"style"]] autorelease];
}

- (UserRole*) asUserRole {
    if (![self.tag isEqualToString:@"UserRole"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a UserRole."];
    }
    return [[[UserRole alloc] initWithRoleId:[self attribute:@"id"] andDescription:[self text]] autorelease];
}


@end