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
* Adds Expanz data binding capability to a standard UITableView control.
*/
@interface UITableView (DataPublication)


- (void) setExpanzDataBinding:(BOOL)dataBinding;

/**
* Sets the populate method for data binding. Defaults to 'ListMe'
*/
- (void) setPopulateMethod:(NSString*)populateMethod;

/**
* Sets the query to be used for data binding. If this property is set, it is used instead of populateMethod attribute.
*/
- (void) setQuery:(NSString*)query;

/**
* Sets autoPopulate for data binding. Defaults to YES.
*/
- (void) setAutoPopulate:(BOOL)autoPopulate;

@end