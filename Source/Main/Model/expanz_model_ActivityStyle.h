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


@interface expanz_model_ActivityStyle : NSObject

@property (nonatomic, readonly) NSString* name;

+ (expanz_model_ActivityStyle*) defaultStyle;
+ (expanz_model_ActivityStyle*) browseStyle;
+ (expanz_model_ActivityStyle*) fromString:(NSString*)string;

- (id) initWithName:(NSString*)name;
- (BOOL) isDefault;
- (BOOL) isBrowse;

@end
/* ================================================================================================================== */
@compatibility_alias ActivityStyle expanz_model_ActivityStyle;