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

#import "../../../../../../Dependencies/External/RaptureXML/RXMLElement+ListAvailableSites+ListAvailableSites+ListAvailableSites.h"
@class expanz_model_Menu;
@class expanz_model_ProcessArea;
@class expanz_model_ActivityDefinition;
@class expanz_model_UserRole;

/**
 * Category for parsing GetSessionData response. 
 */
@interface RXMLElement (SessionData)

- (expanz_model_Menu*) asMenu; 
- (expanz_model_ProcessArea*) asProcessArea;
- (expanz_model_ActivityDefinition*) asActivityDefinition;
- (expanz_model_UserRole*) asUserRole; 



@end
