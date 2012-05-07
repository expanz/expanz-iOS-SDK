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

@class expanz_ui_UITableViewQuery;
@class expanz_ui_FieldFilter;

/**
* Adds Expanz data binding capability to a standard UITableView control.
*/
@interface UITableView (DataPublication)

@property (nonatomic, strong) IBOutlet expanz_ui_FieldFilter* fieldFilter;

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

/**
* Sets the contextObject for data binding. Defaults to the main activity object.
*/
- (void) setContextObject:(NSString*)contextObject;

/**
* List of field names to display, or nil for `expanz_ui_GridDataRenderer` to infer.
*/
- (NSArray*) fieldNames;



@end