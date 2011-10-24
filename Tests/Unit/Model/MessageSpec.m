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

describe(@"object creation", ^{
    it(@"should allow initialization with messageType and message attributes", ^{
        
        Message* message = [[Message alloc] initWithMessageType:MessageTypeWarning content:@"abcd is not a valid number."]; 
        assertThatInt(message.messageType, equalToInt(MessageTypeWarning)); 
        assertThat(message.content, equalTo(@"abcd is not a valid number."));
        [message release];
                
    });
});



SPEC_END