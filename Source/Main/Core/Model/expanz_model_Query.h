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

@class expanz_model_FieldSchema;

@interface expanz_model_Query : NSObject {

@private
    NSMutableArray* _fields;
}

@property(nonatomic, strong, readonly) NSString* queryId;

- (id) initWithQueryId:(NSString*)queryId;

- (NSArray*) fields;

- (void) addField:(expanz_model_FieldSchema*)fieldSchema;

@end
/* ================================================================================================================== */
@compatibility_alias Query expanz_model_Query;