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

/**
* Included in `expanz_model_ActivityInstance` to indicate that a file resource is available.
*/
@interface expanz_model_FileResource : NSObject

@property(nonatomic, strong) NSString* path;
@property(nonatomic, strong) NSString* ext;
@property(nonatomic, strong) NSString* field;

- (id) initWithPath:(NSString*)path ext:(NSString*)ext field:(NSString*)field;

@end

/* ================================================================================================================== */
@compatibility_alias FileResource expanz_model_FileResource;