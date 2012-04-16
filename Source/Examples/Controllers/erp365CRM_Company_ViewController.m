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

#import "erp365CRM_Company_ViewController.h"

@implementation erp365CRM_Company_ViewController


@synthesize ActiveLeadListType = _ActiveLeadListType;

@synthesize Address = _Address;

@synthesize CompanyDescription = _CompanyDescription;

@synthesize Industry = _Industry;

@synthesize InternalInformationUrl = _InternalInformationUrl;

@synthesize LeadLevel = _LeadLevel;

@synthesize LeadSource = _LeadSource;

@synthesize LeadType = _LeadType;

@synthesize Name = _Name;

@synthesize NextStep = _NextStep;

@synthesize Notes = _Notes;

@synthesize NumberOfEmployees = _NumberOfEmployees;

@synthesize ProblemToOvercome = _ProblemToOvercome;

@synthesize Result = _Result;

@synthesize SearchFilter = _SearchFilter;

@synthesize SolutionDesired = _SolutionDesired;

@synthesize Status = _Status;

@synthesize StrategicInterest = _StrategicInterest;

@synthesize Temperature = _Temperature;

@synthesize Url = _Url;

@synthesize WhyBuyUs = _WhyBuyUs;



@synthesize ActiveLeadListTypeLabel = _ActiveLeadListTypeLabel;

@synthesize AddressLabel = _AddressLabel;

@synthesize CompanyDescriptionLabel = _CompanyDescriptionLabel;

@synthesize IndustryLabel = _IndustryLabel;

@synthesize InternalInformationUrlLabel = _InternalInformationUrlLabel;

@synthesize LeadLevelLabel = _LeadLevelLabel;

@synthesize LeadSourceLabel = _LeadSourceLabel;

@synthesize LeadTypeLabel = _LeadTypeLabel;

@synthesize NameLabel = _NameLabel;

@synthesize NextStepLabel = _NextStepLabel;

@synthesize NotesLabel = _NotesLabel;

@synthesize NumberOfEmployeesLabel = _NumberOfEmployeesLabel;

@synthesize ProblemToOvercomeLabel = _ProblemToOvercomeLabel;

@synthesize ResultLabel = _ResultLabel;

@synthesize SearchFilterLabel = _SearchFilterLabel;

@synthesize SolutionDesiredLabel = _SolutionDesiredLabel;

@synthesize StatusLabel = _StatusLabel;

@synthesize StrategicInterestLabel = _StrategicInterestLabel;

@synthesize TemperatureLabel = _TemperatureLabel;

@synthesize UrlLabel = _UrlLabel;

@synthesize WhyBuyUsLabel = _WhyBuyUsLabel;



- (IBAction) doDefaultActionMenu {
    [super sendMethodInvocation:@"DefaultActionMenu"];
}

- (IBAction) doDelete {
    [super sendMethodInvocation:@"Delete"];
}

- (IBAction) doDeleteConfirm {
    [super sendMethodInvocation:@"DeleteConfirm"];
}

- (IBAction) doEditKeyContact {
    [super sendMethodInvocation:@"EditKeyContact"];
}

- (IBAction) doEditSalesPerson {
    [super sendMethodInvocation:@"EditSalesPerson"];
}

- (IBAction) doInteractionsView {
    [super sendMethodInvocation:@"InteractionsView"];
}

- (IBAction) doPrintMe {
    [super sendMethodInvocation:@"PrintMe"];
}

- (IBAction) doRefresh {
    [super sendMethodInvocation:@"Refresh"];
}

- (IBAction) doRestart {
    [super sendMethodInvocation:@"Restart"];
}

- (IBAction) doSave {
    [super sendMethodInvocation:@"Save"];
}



@end
