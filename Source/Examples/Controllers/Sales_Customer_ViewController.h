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
#import "expanz_ui_ActivityInstanceViewController.h"


@interface Sales_Customer_ViewController : expanz_ui_ActivityInstanceViewController

@property(nonatomic, retain) IBOutlet UILabel* FirstNameLabel;
@property(nonatomic, retain) IBOutlet UILabel* LastNameLabel;
@property(nonatomic, retain) IBOutlet UILabel* EmailLabel;
@property(nonatomic, retain) IBOutlet UILabel* PhoneLabel;
@property(nonatomic, retain) IBOutlet UIView* FirstName;
@property(nonatomic, retain) IBOutlet UIView* LastName;
@property(nonatomic, retain) IBOutlet UIView* Email;
@property(nonatomic, retain) IBOutlet UIView* Phone;
@property(nonatomic, retain) IBOutlet UIView* CustomerPhoto;

- (IBAction) Save;

@end