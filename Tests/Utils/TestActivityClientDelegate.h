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
#import "expanz_service_ActivityClient.h"

@interface TestActivityClientDelegate : NSObject<expanz_service_ActivityClientDelegate> 

@property (nonatomic, retain) ActivityInstance* activityInstance; 
@property (nonatomic, retain) NSError* error; 

@end