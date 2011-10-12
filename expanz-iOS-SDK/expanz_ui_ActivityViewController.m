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

#import "Objection.h"
#import "expanz_iOS_SDKExceptions.h"
#import "expanz_ui_ActivityViewController.h"
#import "expanz_model_SessionContextHolder.h"

@implementation expanz_ui_ActivityViewController

//TODO: Replace this with a static
#define kMenuId @"ExpanzMenu"

@synthesize sessionDataClient = _sessionDataClient;
@synthesize menu = _menu;
@synthesize menuTable = _menuTable;

/* ================================================== Constructors ================================================== */

- (id) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self) {
        [NSException raise:ExObjectInitializationException format:@"Call to super-class initialization failed."];
    }
     _sessionDataClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_SessionDataClient)];
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
- (void) viewDidLoad {
    [super viewDidLoad];
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
