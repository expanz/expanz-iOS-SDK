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
#import "expanz_model_AbstractData.h"

@class expanz_model_Folder;


@interface expanz_model_TreeData : expanz_model_AbstractData {

@private
    NSMutableArray* _folders;
}

- (NSArray*) folders;

- (expanz_model_Folder*) folderWithId:(NSString*)folderId;

- (void) addFolder:(expanz_model_Folder*)folder;


@end

/* ================================================================================================================== */
@compatibility_alias TreeData expanz_model_TreeData;