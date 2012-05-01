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
    DetailLayoutStyle, SummaryListLayoutStyle
} ActivityStyleFormLayout;


@interface expanz_model_ActivityStyle : NSObject

@property(nonatomic, strong) NSString* name;
@property(nonatomic, readonly) ActivityStyleFormLayout formLayout;

+ (expanz_model_ActivityStyle*) defaultStyle;

+ (expanz_model_ActivityStyle*) browseStyle;

+ (expanz_model_ActivityStyle*) fromString:(NSString*)string;

- (id) initWithName:(NSString*)name;

- (id) initWithName:(NSString*)name formLayout:(ActivityStyleFormLayout)formLayout;

- (BOOL) isDefault;

- (BOOL) isBrowse;

@end
/* ================================================================================================================== */
@compatibility_alias ActivityStyle expanz_model_ActivityStyle;