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

#import <Objection-iOS/Objection.h>
#import "expanz_model_ProcessArea.h"
#import "expanz_model_ActivityDefinition.h"
#import "expanz_model_Menu.h"
#import "expanz_model_SessionContext.h"
#import "expanz_service_SessionDataRequest.h"
#import "expanz_ui_ActivityMenuViewController.h"
#import "expanz_ui_NavigationManager.h"


@implementation expanz_ui_ActivityMenuViewController

@synthesize menu = _menu;
@synthesize menuTable = _menuTable;

/* ================================================== Initializers ================================================== */

- (id)init {
    self = [super initWithNibName:@"ActivityMenu" bundle:[NSBundle mainBundle]];
    if (self) {
        self.title = @"activities";
        _sessionDataClient =
            [[[JSObjection globalInjector] getObject:@protocol(expanz_service_SessionDataClient)] retain];
        _activityManger = [[[JSObjection globalInjector] getObject:[NavigationManager class]] retain];
        _reporter = [[[JSObjection globalInjector] getObject:@protocol(expanz_ui_SystemEventReporter)] retain];

        SessionDataRequest* sessionDataRequest =
            [[[SessionDataRequest alloc] initWithSessionToken:[SessionContext globalContext].sessionToken] autorelease];
        [_sessionDataClient retrieveSessionDataWith:sessionDataRequest delegate:self];
    }
    return self;
}


/* ================================================ Delegate Methods ================================================ */

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

/* ================================================================================================================== */
#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidUnload {
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

- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView {
    if (tableView.style == UITableViewStyleGrouped) {
        return [_menu.processAreas count];
    }
    else {
        return 1;
    }
}


- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView.style == UITableViewStyleGrouped) {
        return [[[_menu.processAreas objectAtIndex:section] activities] count];
    }
    else {
        return [[_menu allActivities] count];
    }
}

- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section {
    if (tableView.style == UITableViewStyleGrouped) {
        return [[_menu.processAreas objectAtIndex:section] title];
    }
    else {
        return nil;
    }
}


- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath {
    static NSString* reuseId = @"ActivityMenu";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell =
            [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId] autorelease];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.detailTextLabel.textColor = [UIColor darkGrayColor];
        cell.detailTextLabel.backgroundColor = [UIColor clearColor];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    if (tableView.style == UITableViewStyleGrouped) {
        ProcessArea* processArea = [_menu.processAreas objectAtIndex:indexPath.section];
        ActivityDefinition* activity = [processArea.activities objectAtIndex:indexPath.row];
        cell.textLabel.text = [activity title];
    }
    else {
        ActivityDefinition* activity = [[_menu allActivities] objectAtIndex:indexPath.row];
        cell.textLabel.text = [activity title];
    }
    return cell;
}

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath {
    ActivityDefinition* activityDefinition;
    if (tableView.style == UITableViewStyleGrouped) {
        ProcessArea* processArea = [_menu.processAreas objectAtIndex:indexPath.section];
        activityDefinition = [processArea.activities objectAtIndex:indexPath.row];
    }
    else {
        activityDefinition = [[_menu allActivities] objectAtIndex:indexPath.row];
    }
    if ([_activityManger showActivityWithDefinition:activityDefinition]) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

/* ================================================================================================================== */
#pragma mark SessionDataClientDelegate 

- (void)requestDidFinishWithMenu:(Menu*)menu {
    _menu = [menu retain];
    [self.menuTable reloadData];
}

- (void)requestDidFailWithError:(NSError*)error {
    [_reporter reportErrorWithReason:@"There was an unrecoverable error accessing data for the main menu."];
}

/* ================================================== Utility Methods =============================================== */
- (void)dealloc {
    [_sessionDataClient release];
    [_activityManger release];
    [_reporter release];
    [_menu release];
    [_menuTable release];
    [super dealloc];
}


@end
