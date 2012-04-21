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
#import "expanz_model_MenuItem.h"

@interface expanz_model_ActivityMenu : NSObject {

@private
    NSMutableArray* _activities;
}

@property(nonatomic, strong, readonly) NSArray* activities;

- (void) addMenuItem:(expanz_model_MenuItem*)menuItem;

@end
/* ================================================================================================================== */
@compatibility_alias ActivityMenu expanz_model_ActivityMenu;