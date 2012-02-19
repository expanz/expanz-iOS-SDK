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
#import "xml_Serializable.h"
@class expanz_model_ActivityInstance; 

@interface expanz_service_MethodInvocationRequest : NSObject<xml_Serializable>

@property(nonatomic, strong) expanz_model_ActivityInstance* activityInstance;
@property(nonatomic, strong) NSString* methodName;

- (id) initWithActivityInstance:(expanz_model_ActivityInstance*)activityInstance methodName:(NSString*)methodName;

@end

/* ================================================================================================================== */
@compatibility_alias MethodInvocationRequest expanz_service_MethodInvocationRequest;