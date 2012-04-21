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

@interface erp365CRM_Company_Browse_ViewController : expanz_ui_ActivityInstanceViewController


@property(nonatomic, weak) IBOutlet UITableView* CompanyInteractionsQueryTableView;

@property(nonatomic, weak) IBOutlet UITableView* CompanyNamesQueryTableView;

@property(nonatomic, weak) IBOutlet UITableView* CompanyOpportunitiesQueryTableView;

@property(nonatomic, weak) IBOutlet UITableView* CompanyOpportunityDescriptionsQueryTableView;

@property(nonatomic, weak) IBOutlet UITableView* CompanyPeopleDescriptionsQueryTableView;

@property(nonatomic, weak) IBOutlet UITableView* CompanyPeopleQueryTableView;

@property(nonatomic, weak) IBOutlet UITableView* CompanySummaryQueryTableView;



@end