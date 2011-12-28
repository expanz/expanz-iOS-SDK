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


#import "SpecHelper.h"
#import "expanz_model_Message.h"

SPEC_BEGIN(MessageSpec)


__block Message* message;

describe(@"object creation", ^{
    it(@"should allow initialization with messageType and message attributes", ^{
        
        message = [[Message alloc] initWithMessageType:MessageTypeWarning content:@"abcd is not a valid number."]; 
        assertThatInt(message.messageType, equalToInt(MessageTypeWarning)); 
        assertThat(message.content, equalTo(@"abcd is not a valid number."));
        assertThat([message messageTypeAsString], equalTo(@"Warning"));
        
        message = [[Message alloc] initWithMessageType:MessageTypeError content:@"abcd is not a valid number."]; 
        assertThat([message messageTypeAsString], equalTo(@"Error"));                    
    });
    
    it(@"should throw NSInternalInconsistency exception for unknown message type.", ^{
        @try {
            message = [[Message alloc] initWithMessageType:999 content:@"abcd is not a valid number."]; 
            [NSException raise:@"Should have thrown" format:@"Should have thrown"]; 
        }
        @catch (NSException* e){
            assertThat([e reason], equalTo(@"Unknown message type."));
        }

        
    });
});



SPEC_END