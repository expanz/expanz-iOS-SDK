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

@class expanz_model_File;


@interface expanz_model_Folder : NSObject {

@private
    NSMutableArray* _files;
}

@property(nonatomic, strong, readonly) NSString* folderId;
@property(nonatomic, strong, readonly) NSString* title;
@property(nonatomic, strong, readonly) NSString* hint;
@property(nonatomic, strong, readonly) NSString* buttonTitle;
@property(nonatomic, strong, readonly) NSString* sequence;

- (id)initWithFolderId:(NSString*)folderId title:(NSString*)title hint:(NSString*)hint
           buttonTitle:(NSString*)buttonTitle sequence:(NSString*)sequence;

- (NSArray*) files;
- (void) addFile:(expanz_model_File*)file;

@end

/* ================================================================================================================== */
@compatibility_alias Folder expanz_model_Folder;