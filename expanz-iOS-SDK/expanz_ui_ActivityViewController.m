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

#import "expanz_ui_ActivityViewController.h"
#import "Objection.h"
#import "expanz_service_SessionContextHolder.h"

@implementation expanz_ui_ActivityViewController

//TODO: Replace this with a static
#define kMenuId @"ExpanzMenu"

@synthesize sessionDataClient = _sessionDataClient;
@synthesize menu = _menu;
@synthesize menuTable = _menuTable;

/* ================================================ Delegate Methods ================================================ */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

/* ================================================================================================================== */
#pragma mark - View lifecycle
- (void) viewDidLoad {
    [super viewDidLoad];
    _sessionDataClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_SessionDataClient)];
    SessionDataRequest* sessionDataRequest = [[SessionDataRequest alloc] 
                                              initWithSessionToken:[SessionContextHolder globalContext].sessionToken];
    [_sessionDataClient retrieveSessionDataWith:sessionDataRequest delegate:self];
    [sessionDataRequest release];
}

- (void) viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/* ================================================================================================================== */
#pragma mark table view

- (NSInteger) numberOfSectionsInTableView:(UITableView*)tableView {
    return [_menu.processAreas count];
}


- (NSInteger) tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[_menu.processAreas objectAtIndex:section] activities] count];
}

- (NSString*) tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    return [[_menu.processAreas objectAtIndex:section] title];
}


-(UITableViewCell*) tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:kMenuId];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kMenuId] autorelease];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    ProcessArea* processArea = [_menu.processAreas objectAtIndex:indexPath.section];
    Activity* activity = [processArea.activities objectAtIndex:indexPath.row];
    cell.textLabel.text = [activity title];    
    return cell;    
}


/* ================================================================================================================== */
#pragma mark SessionDataClientDelegate 

- (void) requestDidFinishWithMenu:(Menu*)menu {
    LogDebug(@"%@", menu);
    _menu = [menu retain];
    [self.menuTable reloadData];
}

- (void) requestDidFailWithError:(NSError*)error {
    
}

/* ================================================== Utility Methods =============================================== */



- (void) dealloc {
    
    [super dealloc];
}


@end
