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

#import "ESA_Sales_CalcViewController.h"

@implementation ESA_Sales_CalcViewController

@synthesize ResultLabel = _ResultLabel;
@synthesize Op1Label = _Op1Label;
@synthesize Op2Label = _Op2Label;
@synthesize Result = _ResultField;
@synthesize Op1 = _Op1Field;
@synthesize Op2 = _Op2Field;
@synthesize add = _add; 
@synthesize subtract = _subtract;
@synthesize multiply = _multiply;
@synthesize divide = _divide;


/* ================================================ Interface Methods =============================================== */
- (IBAction) addClicked {
    [self sendMethodInvocation:@"Add"];
}

- (IBAction) subtractClicked {
    [self sendMethodInvocation:@"Subtract"];

}

- (IBAction) multiplyClicked {
    [self sendMethodInvocation:@"Multiply"];

}

- (IBAction) divideClicked {
    [self sendMethodInvocation:@"Divide"];
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_ResultLabel release];
    [_Op1Label release]; 
    [_Op2Label release];
    [_ResultField release];
    [_Op1Field release];
    [_Op2Field release];
    [_add release]; 
    [_subtract release]; 
    [_multiply release]; 
    [_divide release];
    [super dealloc];
}


@end
