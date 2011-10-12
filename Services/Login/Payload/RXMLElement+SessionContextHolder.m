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

#import "RXMLElement+SessionContextHolder.h"

@implementation RXMLElement (SessionContextHolder)

- (SessionContextHolder*) asSessionContextHolder {
    if (![self.tag isEqualToString:@"CreateSessionXResponse"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a CreateSessionXResponse."];
    }

    SessionContextHolder* sessionContextHolder; 
    RXMLElement* sessionToken = [self child:@"CreateSessionXResult"];
    RXMLElement* error = [self child:@"errorMessage"]; 
    NSString* message = error.text;         
    
    if (sessionToken.text.length > 0) {
        BOOL hasWarning = NO; 
        if (error != nil) {
            hasWarning = YES;  
        }
        sessionContextHolder = [[[SessionContextHolder alloc] initWithSessionToken:sessionToken.text hasError:NO 
                                                            hasWarning:hasWarning message:message] autorelease];
     }
     else {            
         if (error != nil) {
                sessionContextHolder = [[[SessionContextHolder alloc] initWithSessionToken:nil hasError:YES 
                                                                hasWarning:NO message:message] autorelease];
            }
            else {
                [NSException raise:ExXmlValidationException format:@"Contains neither a session token or an error message."];
            }
        }        
    return sessionContextHolder;
}

@end
