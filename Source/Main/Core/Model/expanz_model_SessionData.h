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

@class expanz_model_Menu;


@interface expanz_model_SessionData : NSObject

@property(nonatomic, strong, readonly) NSString* operationalMode;
@property(nonatomic, strong, readonly) NSString* timeZone;
@property(nonatomic, strong, readonly) NSString* filedownLoadPrefix;
@property(nonatomic, strong, readonly) NSString* userCultureName;
@property(nonatomic, strong, readonly) expanz_model_Menu* menu;

- (id) initWithOperationalMode:(NSString*)operationalMode timeZone:(NSString*)timeZone
        filedownLoadPrefix:(NSString*)filedownLoadPrefix userCultureName:(NSString*)userCultureName
        menu:(expanz_model_Menu*)menu;

@end