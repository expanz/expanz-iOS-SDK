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


@interface expanz_model_File : NSObject

@property (nonatomic, readonly) NSString* fileId;
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* hint;
@property (nonatomic, readonly) NSString* fileName;
@property (nonatomic, readonly) NSString* sequence;
@property (nonatomic, readonly) NSString* type;
@property (nonatomic, readonly) NSString* field;
 
- (id) initWithFileId:(NSString*)fileId title:(NSString*)title hint:(NSString*)hint fileName:(NSString*)fileName 
             sequence:(NSString*)sequence type:(NSString*)type field:(NSString*)field;

@end