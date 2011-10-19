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
@class expanz_model_ActivityInstance;
@class expanz_model_Field; 

@class expanz_model_Field;

@interface RXMLElement (ActivityInstance)

- (expanz_model_ActivityInstance*) asActivityInstance;
- (expanz_model_Field*) asField; 

@end
