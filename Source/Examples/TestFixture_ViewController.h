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


@interface TestFixture_ViewController : expanz_ui_ActivityInstanceViewController



@property(nonatomic, strong) IBOutlet UILabel* ResultLabel;
@property(nonatomic, strong) IBOutlet UILabel* Op1Label;
@property(nonatomic, strong) IBOutlet UILabel* Op2Label;
@property(nonatomic, strong) IBOutlet UITextField* Result;
@property(nonatomic, strong) IBOutlet UITextField* Op1;
@property(nonatomic, strong) IBOutlet UITextField* Op2;
@property(nonatomic, strong) IBOutlet UIButton* add;
@property(nonatomic, strong) IBOutlet UIButton* subtract;
@property(nonatomic, strong) IBOutlet UIButton* multiply;
@property(nonatomic, strong) IBOutlet UIButton* divide;

@property(nonatomic, strong) IBOutlet UITableView* customersList;

@end