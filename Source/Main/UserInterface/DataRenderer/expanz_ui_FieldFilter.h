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


@interface expanz_ui_FieldFilter : NSObject {

@private
    NSMutableArray* _fields;
}

- (NSArray*) fields;

@end
/* ================================================================================================================== */
@compatibility_alias FieldFilter expanz_ui_FieldFilter;