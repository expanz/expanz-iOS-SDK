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
* Represents a file within a `expanz_model_Folder`, as part of a `expanz_model_TreeData` set.
*/
@interface expanz_model_File : NSObject

@property(nonatomic, strong) NSString* fileId;
@property(nonatomic, strong) NSString* title;
@property(nonatomic, strong) NSString* hint;
@property(nonatomic, strong) NSString* fileName;
@property(nonatomic, strong) NSString* sequence;
@property(nonatomic, strong) NSString* type;
@property(nonatomic, strong) NSString* field;
 
- (id) initWithFileId:(NSString*)fileId title:(NSString*)title hint:(NSString*)hint fileName:(NSString*)fileName 
             sequence:(NSString*)sequence type:(NSString*)type field:(NSString*)field;

@end

/* ================================================================================================================== */
@compatibility_alias File expanz_model_File;