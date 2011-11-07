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


#import "Sales_Customer_ViewController.h"

@implementation Sales_Customer_ViewController

@synthesize FirstNameLabel;
@synthesize LastNameLabel;
@synthesize EmailLabel;
@synthesize PhoneLabel;
@synthesize FirstName;
@synthesize LastName;
@synthesize Email;
@synthesize Phone;

- (void) dealloc {
    [FirstNameLabel release];
    [LastNameLabel release];
    [EmailLabel release];
    [PhoneLabel release];
    [FirstName release];
    [LastName release];
    [Email release];
    [Phone release];
    [super dealloc];
}

@end