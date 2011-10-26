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

#import "expanz_ui_ActivityInstanceViewController.h"

@interface expanz_ui_BasicCalculatorViewController : expanz_ui_ActivityInstanceViewController

@property (nonatomic, retain) IBOutlet UILabel* ResultLabel;
@property (nonatomic, retain) IBOutlet UILabel* Op1Label; 
@property (nonatomic, retain) IBOutlet UILabel* Op2Label;
@property (nonatomic, retain) IBOutlet UITextField* Result; 
@property (nonatomic, retain) IBOutlet UITextField* Op1; 
@property (nonatomic, retain) IBOutlet UITextField* Op2; 
@property (nonatomic, retain) IBOutlet UIButton* add; 
@property (nonatomic, retain) IBOutlet UIButton* subtract;
@property (nonatomic, retain) IBOutlet UIButton* multiply;
@property (nonatomic, retain) IBOutlet UIButton* divide; 


- (IBAction) addClicked; 
- (IBAction) subtractClicked; 
- (IBAction) multiplyClicked; 
- (IBAction) divideClicked; 

@end

/* ================================================================================================================== */
@compatibility_alias BasicCalculatorViewController expanz_ui_BasicCalculatorViewController;
