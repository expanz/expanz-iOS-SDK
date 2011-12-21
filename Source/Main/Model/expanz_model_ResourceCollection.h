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

@class expanz_model_FileResource;
@class expanz_model_Field;


@interface expanz_model_ResourceCollection : NSObject {

@private
    NSMutableSet* _fileResources;

}

@property(nonatomic, strong, readonly) NSArray* fileResources;


- (void) addFileResource:(expanz_model_FileResource*)fileResource;


@end

/* ================================================================================================================== */
@compatibility_alias ResourceCollection expanz_model_ResourceCollection;