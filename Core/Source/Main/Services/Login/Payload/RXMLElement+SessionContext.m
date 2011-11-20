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

#import "RXMLElement+SessionContext.h"
#import "expanz_iOS_SDKExceptions.h"
#import "expanz_model_SessionContext.h"

@implementation RXMLElement (SessionContext)

- (SessionContext*) asSessionContext {
    if (![self.tag isEqualToString:@"CreateSessionXResponse"]) {
        [NSException raise:ExXmlValidationException format:@"Element is not a CreateSessionXResponse."];
    }

    SessionContext* sessionContext; 
    RXMLElement* sessionToken = [self child:@"CreateSessionXResult"];
    RXMLElement* error = [self child:@"errorMessage"]; 
    NSString* message = error.text;         
    
    if (sessionToken.text.length > 0) {
        BOOL hasWarning = NO; 
        if (error != nil) {
            hasWarning = YES;  
        }
        sessionContext = [[[SessionContext alloc] initWithSessionToken:sessionToken.text hasError:NO 
                                                            hasWarning:hasWarning message:message] autorelease];
     }
     else {            
         if (error != nil) {
                sessionContext = [[[SessionContext alloc] initWithSessionToken:nil hasError:YES 
                                                                hasWarning:NO message:message] autorelease];
            }
            else {
                [NSException raise:ExXmlValidationException 
                            format:@"Contains neither a session token or an error message."];
            }
        }        
    return sessionContext;
}

@end
