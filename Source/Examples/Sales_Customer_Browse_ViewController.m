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

#import "Sales_Customer_Browse_ViewController.h"

@implementation Sales_Customer_Browse_ViewController

@synthesize customersList = _customersList;


- (void) dealloc {
    [_customersList release];
    [super dealloc];
}

@end
