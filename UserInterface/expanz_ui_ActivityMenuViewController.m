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
#import "expanz_iOS_SDKAppDelegate.h"
#import "expanz_iOS_SDKExceptions.h"
#import "expanz_model_SessionContext.h"
#import "expanz_model_ProcessArea.h"
#import "expanz_model_Activity.h"
#import "expanz_model_Menu.h"
#import "expanz_ui_ActivityMenuViewController.h"
#import "expanz_ui_ActivityInstanceViewController.h"
#import "ESA_Sales_CalcViewController.h"


@implementation expanz_ui_ActivityMenuViewController

@synthesize sessionDataClient = _sessionDataClient;
@synthesize menu = _menu;
@synthesize menuTable = _menuTable;

/* ================================================== Constructors ================================================== */

- (id) init {
    self = [super initWithNibName:@"ActivityMenu" bundle:[NSBundle mainBundle]];
    if (self) {
        self.title = @"activities";
        _sessionDataClient = [[JSObjection globalInjector] getObject:@protocol(expanz_service_SessionDataClient)];
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
    static NSString* reuseId = @"ActivityMenu";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId] autorelease];
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

- (void) tableView: (UITableView*) tableView didSelectRowAtIndexPath: (NSIndexPath*) indexPath {
    ProcessArea* processArea = [_menu.processAreas objectAtIndex:indexPath.section]; 
    Activity* activity = [processArea.activities objectAtIndex:indexPath.row];
    
    //TODO: Look up view controller from formmapping.xml
    NSMutableString* controllerClassName = [[NSMutableString alloc] init];
    [controllerClassName appendString:[activity.name stringByReplacingOccurrencesOfString:@"." withString:@"_"]];
    [controllerClassName appendString:@"ViewController"];
    id clazz = objc_getClass([controllerClassName cStringUsingEncoding:NSASCIIStringEncoding]);
    if (clazz == nil) {
        NSString * errorMessage = [NSString stringWithFormat:@"No controller exists named %@", controllerClassName];
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error" message:errorMessage delegate:self
                                                  cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        [alert release];
    }
    else {
        ActivityInstanceViewController* nextView = class_createInstance(clazz, 0);
        nextView = [nextView initWithActivity:activity];
        SDKAppDelegate* delegate = [UIApplication sharedApplication].delegate;
        [delegate.navigationController pushViewController:nextView animated:YES];
        [nextView release];
    }
}

/* ================================================================================================================== */
#pragma mark SessionDataClientDelegate 

- (void) requestDidFinishWithMenu:(Menu*)menu {
    _menu = [menu retain];
    [self.menuTable reloadData];
}

- (void) requestDidFailWithError:(NSError*)error {
    
}

/* ================================================== Utility Methods =============================================== */



- (void) dealloc {
    LogDebug(@"!!!!!!!!!!!!!!!!!!!! In dealloc!!!!!!!!!!!!"); 
    [_sessionDataClient release]; 
    [_menu release]; 
    [_menuTable release];
    [super dealloc];
}


@end
