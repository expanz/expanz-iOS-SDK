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

@implementation expanz_model_Message

@synthesize messageType = _messageType;
@synthesize messageTypeAsString = _messageTypeAsString;
@synthesize content = _content;


/* ================================================== Initializers ================================================== */

- (id) initWithMessageType:(MessageType)messageType content:(NSString*)content {
    self = [super init];
    if (self) {
        _messageType = messageType;
        switch (messageType) {
            case 0:
                _messageTypeAsString = @"Warning";
                break;
            case 1:
                _messageTypeAsString = @"Error";
                break;
            default:
                [NSException raise:NSInternalInconsistencyException format:@"Unknown message type."];
                break;
        }
        _content = [content copy];
    }
    return self;
}


@end
