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


/* ================================================================================================================== */
@protocol expanz_service_ActivityDetailsClientDelegate <NSObject>

- (void) requestDidFinishWithActivityDetails:(id)activityDetails; 
- (void) requestDidFailWithError:(NSError*)error; 

@end

/* ================================================================================================================== */

@protocol expanz_service_CreateActivityClient <NSObject>

- (void) retrieveActivityDetailsWith:(id)request delegate:(id<expanz_service_LoginClientDelegate>)delegate;

@end
