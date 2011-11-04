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

#import <Foundation/Foundation.h>


typedef enum {
    MessageTypeWarning, MessageTypeError
} MessageType;


/* ================================================================================================================== */

/** 
 * Can be returned at the end of an activity transaction, to provide additional user information.
 */
@interface expanz_model_Message : NSObject

@property(nonatomic, readonly) MessageType messageType;
@property(nonatomic, readonly) NSString* messageTypeAsString;
@property(nonatomic, readonly) NSString* content;


- (id) initWithMessageType:(MessageType)messageType content:(NSString*)content;

@end

/* ================================================================================================================== */
@compatibility_alias Message expanz_model_Message;