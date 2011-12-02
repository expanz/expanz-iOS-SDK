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
#import "expanz_model_BaseData.h"

@class expanz_model_Folder;


@interface expanz_model_TreeData : expanz_model_BaseData {

@private
    NSMutableArray* _folders;
}

- (NSArray*) folders;
- (void) addFolder:(expanz_model_Folder*)folder;


@end

/* ================================================================================================================== */
@compatibility_alias TreeData expanz_model_TreeData;