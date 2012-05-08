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

#import "erp365CRM_Person_ViewController.h"

@implementation erp365CRM_Person_ViewController


@synthesize Blog = _Blog;

@synthesize DirectPhone = _DirectPhone;

@synthesize Email = _Email;

@synthesize Email2 = _Email2;

@synthesize Facebook = _Facebook;

@synthesize FirstName = _FirstName;

@synthesize FullName = _FullName;

@synthesize LastName = _LastName;

@synthesize LinkedIn = _LinkedIn;

@synthesize MetInPerson = _MetInPerson;

@synthesize MobileNumber = _MobileNumber;

@synthesize Notes = _Notes;

@synthesize PersonType = _PersonType;

@synthesize PreferredPhone = _PreferredPhone;

@synthesize ReceptionPhone = _ReceptionPhone;



@synthesize BlogLabel = _BlogLabel;

@synthesize DirectPhoneLabel = _DirectPhoneLabel;

@synthesize EmailLabel = _EmailLabel;

@synthesize Email2Label = _Email2Label;

@synthesize FacebookLabel = _FacebookLabel;

@synthesize FirstNameLabel = _FirstNameLabel;

@synthesize FullNameLabel = _FullNameLabel;

@synthesize LastNameLabel = _LastNameLabel;

@synthesize LinkedInLabel = _LinkedInLabel;

@synthesize MetInPersonLabel = _MetInPersonLabel;

@synthesize MobileNumberLabel = _MobileNumberLabel;

@synthesize NotesLabel = _NotesLabel;

@synthesize PersonTypeLabel = _PersonTypeLabel;

@synthesize PreferredPhoneLabel = _PreferredPhoneLabel;

@synthesize ReceptionPhoneLabel = _ReceptionPhoneLabel;

@synthesize scrollView = _scrollView; 


- (IBAction) doDefaultActionMenu {
    [super sendMethodInvocation:@"DefaultActionMenu"];
}

- (IBAction) doDelete {
    [super sendMethodInvocation:@"Delete"];
}

- (IBAction) doDeleteConfirm {
    [super sendMethodInvocation:@"DeleteConfirm"];
}

- (IBAction) doInteractions {
    [super sendMethodInvocation:@"Interactions"];
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
