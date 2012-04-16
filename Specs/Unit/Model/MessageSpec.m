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


#import "expanz_model_Message.h"

SPEC_BEGIN(MessageSpec)


__block Message* message;

describe(@"object creation", ^{
    it(@"should allow initialization with messageType and message attributes", ^{
        
        message = [[Message alloc] initWithMessageType:MessageTypeWarning content:@"abcd is not a valid number."];
        [[theValue(message.messageType) should] equal:theValue(MessageTypeWarning)];
        [[message.content should] equal:@"abcd is not a valid number."];
        [[[message messageTypeAsString] should] equal:@"Warning"];
        
        message = [[Message alloc] initWithMessageType:MessageTypeError content:@"abcd is not a valid number."]; 
        [[[message messageTypeAsString] should] equal:@"Error"];
    });
    
    it(@"should throw NSInternalInconsistency exception for unknown message type.", ^{
        @try {
            message = [[Message alloc] initWithMessageType:999 content:@"abcd is not a valid number."]; 
            [NSException raise:@"Should have thrown" format:@"Should have thrown"]; 
        }
        @catch (NSException* e){
            [[[e reason] should] equal:@"Unknown message type."];
        }

        
    });
});



SPEC_END