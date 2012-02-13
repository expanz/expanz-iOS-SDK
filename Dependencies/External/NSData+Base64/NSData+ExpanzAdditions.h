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

@interface NSData (ExpanzAdditions)

/**
* Creates an NSData object containing the base64 decoded representation of the base64 string 'aString'.
*
* @param aString - the base64 string to decode.
* @returns An autoreleased NSData representation of the base64 string.
//
*/
+ (NSData*) dataFromBase64String:(NSString*)aString;

/**
* Creates an NSString object that contains the base 64 encoding of the receiver's data. Lines are broken at 64
* characters long.
*
* @returns an autoreleased NSString being the base 64 representation of the receiver.
*/
- (NSString*) base64EncodedString;

@end
