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
        _filteredListContent = [NSMutableArray arrayWithCapacity:[_data count]];
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


/* ================================================= Protocol Methods =============================================== */
- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    return nil;
}

@end