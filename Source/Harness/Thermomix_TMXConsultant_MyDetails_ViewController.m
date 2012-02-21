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


#import "Thermomix_TMXConsultant_MyDetails_ViewController.h"

@implementation Thermomix_TMXConsultant_MyDetails_ViewController;

@synthesize FirstName;
@synthesize LastName;
@synthesize EmailAddress;
@synthesize Phone;
@synthesize MobilePhone;
@synthesize ABN;
@synthesize SearchCode;
@synthesize SpecificType;
@synthesize Location_ExtendedName;
@synthesize Location_FindCode;

- (IBAction) Save {
    [super sendMethodInvocation:@"Save"];
}


@end