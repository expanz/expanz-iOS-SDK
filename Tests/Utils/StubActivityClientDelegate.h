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
#import "ExpanzActivityClient.h"

@class expanz_model_ActivityInstance;

@interface StubActivityClientDelegate : NSObject<ExpanzActivityClientDelegate>

@property(nonatomic, strong) expanz_model_ActivityInstance* activityInstance;
@property(nonatomic, strong) NSError* error;

@end