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

@class expanz_model_BaseData;
@class expanz_model_Row;
@class expanz_model_Column;
@class expanz_model_Folder;

/**
* Assembles an instance of `expanz_model_GridData` or `expanz_model_TreeData` depending on weather rows, columns or
* folders are added.
*/
@interface expanz_model_DataBuilder : NSObject {

@private
    expanz_model_BaseData* _data;
}

@property (nonatomic, readonly) NSString* dataId;
@property (nonatomic, readonly) NSString* source;

- (id) initWithDataId:(NSString*)dataId source:(NSString*)source;

- (expanz_model_BaseData*) build;

- (void) addRow:(expanz_model_Row*)row;

- (void) addColumn:(expanz_model_Column*)column;

- (void) addFolder:(expanz_model_Folder*)folder;

@end

/* ================================================================================================================== */
@compatibility_alias DataBuilder expanz_model_DataBuilder;