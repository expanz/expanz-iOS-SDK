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

#import "expanz_model_Activity.h"

@interface expanz_model_ActivityInstance : expanz_model_Activity


@property (nonatomic, readonly) NSString* handle; 
@property (nonatomic, readonly) NSString* persistentId;

- (id) initWithTitle:(NSString*)title handle:(NSString*)handle persistentId:(NSString*)persistentId;

@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstance expanz_model_ActivityInstance;
