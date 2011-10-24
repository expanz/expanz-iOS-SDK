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
@synthesize content = _content;

/* ================================================== Constructors ================================================== */

- (id) initWithMessageType:(MessageType)messageType content:(NSString*)content {
    self = [super init]; 
    if (self) {
        _messageType = messageType;
        _content = [content retain];
    }
    return self;
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_content release]; 
    [super dealloc];
}

@end
