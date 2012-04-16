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

@interface erp365CRM_Company_ViewController : expanz_ui_ActivityInstanceViewController


@property(nonatomic, weak) IBOutlet UIView* ActiveLeadListType;

@property(nonatomic, weak) IBOutlet UIView* Address;

@property(nonatomic, weak) IBOutlet UIView* CompanyDescription;

@property(nonatomic, weak) IBOutlet UIView* Industry;

@property(nonatomic, weak) IBOutlet UIView* InternalInformationUrl;

@property(nonatomic, weak) IBOutlet UIView* LeadLevel;

@property(nonatomic, weak) IBOutlet UIView* LeadSource;

@property(nonatomic, weak) IBOutlet UIView* LeadType;

@property(nonatomic, weak) IBOutlet UIView* Name;

@property(nonatomic, weak) IBOutlet UIView* NextStep;

@property(nonatomic, weak) IBOutlet UIView* Notes;

@property(nonatomic, weak) IBOutlet UIView* NumberOfEmployees;

@property(nonatomic, weak) IBOutlet UIView* ProblemToOvercome;

@property(nonatomic, weak) IBOutlet UIView* Result;

@property(nonatomic, weak) IBOutlet UIView* SearchFilter;

@property(nonatomic, weak) IBOutlet UIView* SolutionDesired;

@property(nonatomic, weak) IBOutlet UIView* Status;

@property(nonatomic, weak) IBOutlet UIView* StrategicInterest;

@property(nonatomic, weak) IBOutlet UIView* Temperature;

@property(nonatomic, weak) IBOutlet UIView* Url;

@property(nonatomic, weak) IBOutlet UIView* WhyBuyUs;



@property(nonatomic, weak) IBOutlet UILabel* ActiveLeadListTypeLabel;

@property(nonatomic, weak) IBOutlet UILabel* AddressLabel;

@property(nonatomic, weak) IBOutlet UILabel* CompanyDescriptionLabel;

@property(nonatomic, weak) IBOutlet UILabel* IndustryLabel;

@property(nonatomic, weak) IBOutlet UILabel* InternalInformationUrlLabel;

@property(nonatomic, weak) IBOutlet UILabel* LeadLevelLabel;

@property(nonatomic, weak) IBOutlet UILabel* LeadSourceLabel;

@property(nonatomic, weak) IBOutlet UILabel* LeadTypeLabel;

@property(nonatomic, weak) IBOutlet UILabel* NameLabel;

@property(nonatomic, weak) IBOutlet UILabel* NextStepLabel;

@property(nonatomic, weak) IBOutlet UILabel* NotesLabel;

@property(nonatomic, weak) IBOutlet UILabel* NumberOfEmployeesLabel;

@property(nonatomic, weak) IBOutlet UILabel* ProblemToOvercomeLabel;

@property(nonatomic, weak) IBOutlet UILabel* ResultLabel;

@property(nonatomic, weak) IBOutlet UILabel* SearchFilterLabel;

@property(nonatomic, weak) IBOutlet UILabel* SolutionDesiredLabel;

@property(nonatomic, weak) IBOutlet UILabel* StatusLabel;

@property(nonatomic, weak) IBOutlet UILabel* StrategicInterestLabel;

@property(nonatomic, weak) IBOutlet UILabel* TemperatureLabel;

@property(nonatomic, weak) IBOutlet UILabel* UrlLabel;

@property(nonatomic, weak) IBOutlet UILabel* WhyBuyUsLabel;





- (IBAction) doDefaultActionMenu;

- (IBAction) doDelete;

- (IBAction) doDeleteConfirm;

- (IBAction) doEditKeyContact;

- (IBAction) doEditSalesPerson;

- (IBAction) doInteractionsView;

- (IBAction) doPrintMe;

- (IBAction) doRefresh;

- (IBAction) doRestart;

- (IBAction) doSave;



@end

