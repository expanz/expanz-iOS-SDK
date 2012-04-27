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
#import "expanz_ui_AbstractDataRenderer.h"
#import "expanz_model_AbstractData.h"
#import "expanz_ui_NavigationManager.h"


@implementation expanz_ui_AbstractDataRenderer

@synthesize activityManager = _activityManager;
@synthesize data = _data;
@synthesize tableView = _tableView;
@synthesize activityName = _activityName;
@synthesize searchController = _searchController;


/* ================================================== Initializers ================================================== */
- (id) initWithData:(AbstractData*)data tableView:(UITableView*)tableView
        activityName:(NSString*)activityName {

    self = [super init];
    if (self) {
        _data = data;
        _tableView = tableView;
        _activityName = [activityName copy];
        _activityManager = [[JSObjection globalInjector] getObject:[NavigationManager class]];
        _filteredListContent = [[NSMutableArray alloc] init];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (void) makeSearchableWith:(UISearchBar*)searchBar controller:(UIViewController*)controller {
    if (searchBar != nil) {
        LogDebug(@"Binding UISearchBar to UITableView: %@", _tableView);
        _searchController =
                [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:controller];
        _searchController.delegate = self;
        _searchController.searchResultsDataSource = self;
        _searchController.searchResultsDelegate = self;
    }
}

- (void) setBackgroundColorForIndexPath:(NSIndexPath*)indexPath OnCell:(UITableViewCell*)cell {
    if (indexPath.row % 2) {
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:0.969 green:0.969 blue:0.969 alpha:1];
    }
}


/* ================================================= Protocol Methods =============================================== */
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL) searchDisplayController:(UISearchDisplayController*)controller
        shouldReloadTableForSearchString:(NSString*)searchString {

    NSArray* scope = [self.searchController.searchBar scopeButtonTitles];
    NSInteger selectedScopeButtonIndex = [self.searchController.searchBar selectedScopeButtonIndex];
    [self filterContentForSearchText:searchString scope:[scope objectAtIndex:selectedScopeButtonIndex]];
    return YES;
}


- (BOOL) searchDisplayController:(UISearchDisplayController*)controller
        shouldReloadTableForSearchScope:(NSInteger)searchOption {

    NSString* searchText = [self.searchController.searchBar text];
    NSArray* searchScope = [self.searchController.searchBar scopeButtonTitles];
    [self filterContentForSearchText:searchText scope:[searchScope objectAtIndex:searchOption]];
    return YES;
}

- (int) searchOptions {
    return (NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch);
}

/* ================================================= Abstract Methods =============================================== */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void) filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {

}


@end