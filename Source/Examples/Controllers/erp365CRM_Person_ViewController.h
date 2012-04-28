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

@interface erp365CRM_Person_ViewController : expanz_ui_ActivityInstanceViewController


@property(nonatomic, weak) IBOutlet UIView* Blog;

@property(nonatomic, weak) IBOutlet UIView* DirectPhone;

@property(nonatomic, weak) IBOutlet UIView* Email;

@property(nonatomic, weak) IBOutlet UIView* Email2;

@property(nonatomic, weak) IBOutlet UIView* Facebook;

@property(nonatomic, weak) IBOutlet UIView* FirstName;

@property(nonatomic, weak) IBOutlet UIView* FullName;

@property(nonatomic, weak) IBOutlet UIView* LastName;

@property(nonatomic, weak) IBOutlet UIView* LinkedIn;

@property(nonatomic, weak) IBOutlet UIView* MetInPerson;

@property(nonatomic, weak) IBOutlet UIView* MobileNumber;

@property(nonatomic, weak) IBOutlet UIView* Notes;

@property(nonatomic, weak) IBOutlet UIView* PersonType;

@property(nonatomic, weak) IBOutlet UIView* PreferredPhone;

@property(nonatomic, weak) IBOutlet UIView* ReceptionPhone;



@property(nonatomic, weak) IBOutlet UILabel* BlogLabel;

@property(nonatomic, weak) IBOutlet UILabel* DirectPhoneLabel;

@property(nonatomic, weak) IBOutlet UILabel* EmailLabel;

@property(nonatomic, weak) IBOutlet UILabel* Email2Label;

@property(nonatomic, weak) IBOutlet UILabel* FacebookLabel;

@property(nonatomic, weak) IBOutlet UILabel* FirstNameLabel;

@property(nonatomic, weak) IBOutlet UILabel* FullNameLabel;

@property(nonatomic, weak) IBOutlet UILabel* LastNameLabel;

@property(nonatomic, weak) IBOutlet UILabel* LinkedInLabel;

@property(nonatomic, weak) IBOutlet UILabel* MetInPersonLabel;

@property(nonatomic, weak) IBOutlet UILabel* MobileNumberLabel;

@property(nonatomic, weak) IBOutlet UILabel* NotesLabel;

@property(nonatomic, weak) IBOutlet UILabel* PersonTypeLabel;

@property(nonatomic, weak) IBOutlet UILabel* PreferredPhoneLabel;

@property(nonatomic, weak) IBOutlet UILabel* ReceptionPhoneLabel;

@property(nonatomic, weak) IBOutlet UIScrollView* scrollView; 




- (IBAction) doDefaultActionMenu;

- (IBAction) doDelete;

- (IBAction) doDeleteConfirm;

- (IBAction) doInteractions;

- (IBAction) doPrintMe;

- (IBAction) doRefresh;

- (IBAction) doRestart;

- (IBAction) doSave;



@end

