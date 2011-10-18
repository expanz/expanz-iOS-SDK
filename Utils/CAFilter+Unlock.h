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

#import <QuartzCore/QuartzCore.h>

/**
 * Unlock private filter API. TODO: Replace this with Library call. 
 */
@interface CAFilter : NSObject 

+ (CAFilter*) filterWithName: (NSString*) name;

@end
