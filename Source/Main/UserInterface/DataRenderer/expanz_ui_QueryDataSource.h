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


@interface expanz_ui_QueryDataSource : NSObject<UITableViewDataSource> {

@private
    NSMutableDictionary* _cache;
}

- (NSString*) query;

@end
/* ================================================================================================================== */
@compatibility_alias QueryDataSource expanz_ui_QueryDataSource;