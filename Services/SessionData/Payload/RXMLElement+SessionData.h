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

#import "RXMLElement.h"
#import "expanz_model_Menu.h"
#import "expanz_model_ProcessArea.h"
#import "expanz_model_Activity.h"
#import "expanz_model_UserRole.h"

/**
 * Category for parsing GetSessionData response. 
 */
@interface RXMLElement (RXMLElement_SessionData)

- (Menu*) asMenu; 
- (ProcessArea*) asProcessArea;
- (UserRole*) asUserRole; 



@end
