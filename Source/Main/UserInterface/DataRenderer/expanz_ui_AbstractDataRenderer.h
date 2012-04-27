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

@class expanz_model_AbstractData;
@class expanz_ui_NavigationManager;


@interface expanz_ui_AbstractDataRenderer : NSObject<UITableViewDataSource, UITableViewDelegate,
        UISearchDisplayDelegate> {

    NSMutableArray* _filteredListContent;
    NSUInteger _cellHeight;

}

@property(nonatomic, strong) expanz_ui_NavigationManager* activityManager;

/**
* Data to be rendered.
*/
@property(nonatomic, strong, readonly) expanz_model_AbstractData* data;

/**
* UITableView to display the data.
*/
@property(nonatomic, strong, readonly) UITableView* tableView;

/**
* Activity name to use for showing detail of a grid data row.
*/
@property(nonatomic, strong, readonly) NSString* activityName;

/**
* Search controller responsible for filtering results list.
*/
@property(nonatomic, strong, readonly) UISearchDisplayController* searchController;

/**
* Injection point for loading custom table cells from a nib.
*/
@property(nonatomic, weak) IBOutlet UITableViewCell* tableCell;


/**
* Initializes the renderer with data.
*/
- (id) initWithData:(expanz_model_AbstractData*)data tableView:(UITableView*)tableView
        activityName:(NSString*)activityName;


/* ================================================================================================================== */
#pragma mark Searching

/**
* Injection point for a searchBar.
*/
- (void) makeSearchableWith:(UISearchBar*)searchBar controller:(UIViewController*)controller;

/**
* Search options to direct the style of search (case-insensitive, etc) in both GridDataRenderer and TreeDataRender.
*/
- (int) searchOptions;

/**
* Abstract method with concrete implementation in GridDataRenderer and TreeDataRenderer.
*/
- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope;

/**
* Abstract method that returns the name of the nib to use.
*/
- (NSString*) nibNameForTableCell;

- (UITableViewCell*) loadTableCellFromNib;

/* ================================================================================================================== */
- (void) setBackgroundColorForIndexPath:(NSIndexPath*)indexPath OnCell:(UITableViewCell*)cell;

@end

/* ================================================================================================================== */
@compatibility_alias AbstractDataRenderer expanz_ui_AbstractDataRenderer;