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

#import <UIKit/UIKit.h>
#import "expanz_service_ActivityClient.h"
@class expanz_model_Activity;


@interface expanz_ui_ActivityInstanceViewController : UIViewController<expanz_service_ActivityClientDelegate>

@property (nonatomic, readonly) expanz_model_ActivityInstance* activityInstance;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView* spinner;
@property (nonatomic, retain) IBOutlet UILabel* Op1Label; 
@property (nonatomic, retain) IBOutlet UILabel* Op2Label;
@property (nonatomic, retain) IBOutlet UILabel* ResultField; 
@property (nonatomic, retain) IBOutlet UITextField* Op1Field; 
@property (nonatomic, retain) IBOutlet UITextField* Op2Field; 
@property (nonatomic, retain) IBOutlet UIButton* add; 
@property (nonatomic, retain) IBOutlet UIButton* subtract;
@property (nonatomic, retain) IBOutlet UIButton* multiply;
@property (nonatomic, retain) IBOutlet UIButton* divide; 


-(id) initWithActivity:(expanz_model_Activity*)activity; 

- (IBAction) op1ValueChanged; 
- (IBAction) o21ValueChanged; 
- (IBAction) addClicked; 
- (IBAction) subtractClicked; 
- (IBAction) multiplyClicked; 
- (IBAction) divideClicked; 


@end

/* ================================================================================================================== */
@compatibility_alias ActivityInstanceViewController expanz_ui_ActivityInstanceViewController;