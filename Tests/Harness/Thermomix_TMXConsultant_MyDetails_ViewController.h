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


@interface Thermomix_TMXConsultant_MyDetails_ViewController : expanz_ui_ActivityInstanceViewController

@property(nonatomic, retain) IBOutlet UITextField* FirstName;
@property(nonatomic, retain) IBOutlet UITextField* LastName;
@property(nonatomic, retain) IBOutlet UITextField* EmailAddress;
@property(nonatomic, retain) IBOutlet UITextField* Phone;
@property(nonatomic, retain) IBOutlet UITextField* MobilePhone;
@property(nonatomic, retain) IBOutlet UITextField* ABN;
@property(nonatomic, retain) IBOutlet UITextField* SearchCode;
@property(nonatomic, retain) IBOutlet UITextField* SpecificType;
@property(nonatomic, retain) IBOutlet UITextField* Location_ExtendedName;
@property(nonatomic, retain) IBOutlet UITextField* Location_FindCode;

- (IBAction) Save;

@end