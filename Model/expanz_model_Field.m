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

#import "expanz_model_Field.h"

@implementation expanz_model_Field

@synthesize fieldId = _fieldId;
@synthesize nullable = _nullable; 
@synthesize defaultValue = _defaultValue;
@synthesize datatype = _datatype;

/* ================================================== Constructors ================================================== */

- (id) initWithFieldId:(NSString*)fieldId nullable:(BOOL)nullable defaultValue:(NSString*)defaultValue 
              dataType:(NSString*)datatype {
    
    self = [super init]; 
    if (self) {
        _fieldId = [fieldId retain]; 
        _nullable = nullable; 
        _defaultValue = [defaultValue retain]; 
        _datatype = [datatype retain];         
    }
    return self; 
}

/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_fieldId release]; 
    [_defaultValue release]; 
    [_datatype release];
    [super dealloc];
}



@end
