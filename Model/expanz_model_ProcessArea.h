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
#import "expanz_model_Activity.h"

@interface expanz_model_ProcessArea : NSObject {
    
    NSMutableSet* _activities; 
}

@property (nonatomic, readonly) NSString* processId; 
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSArray* activities; 

- (id) initWithProcessId:(NSString*)processId andTitle:(NSString*)title; 
- (void) addActivity:(Activity*)activity; 


@end

/* ================================================================================================================== */
@compatibility_alias ProcessArea expanz_model_ProcessArea;
