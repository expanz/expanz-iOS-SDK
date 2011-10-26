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

//Readonly properties.  
@synthesize fieldId = _fieldId;
@synthesize nullable = _nullable; 
@synthesize defaultValue = _defaultValue;
@synthesize datatype = _datatype;
@synthesize disabled = _disabled;
@synthesize dirty = _dirty;
@synthesize label = _label;
@synthesize hint = _hint;

//Read-write properties. 
@synthesize parentActivity = _parentActivity;
@synthesize value = _value;


/* ================================================== Constructors ================================================== */

- (id) initWithFieldId:(NSString*)fieldId nullable:(BOOL)nullable defaultValue:(NSString*)defaultValue 
              dataType:(NSString*)datatype label:(NSString*)label hint:(NSString*)hint {
    
    self = [super init]; 
    if (self) {
        _fieldId = [fieldId retain]; 
        _nullable = nullable; 
        _defaultValue = [defaultValue retain]; 
        _datatype = [datatype retain];         
        _label = [label retain];
        _hint = [hint retain];
    }
    return self; 
}


/* ================================================ Interface Methods =============================================== */

- (void) didFinishEditWithValue:(NSString*)value {
    LogDebug(@"%@', did finish edit with new value '%@'", [self description], value);
    if (! [_value isEqualToString:value]) {
        [_value release]; 
        _value = [value retain];        
        _dirty = YES;
    }    
}

- (void) didSynchronizeStateWithServerModel:(NSString*)validatedValue {
    if (validatedValue != _value) {
        [_value release]; 
        _value = [validatedValue retain];
    }
    //Field is clean now, weather the server has a new validated value or not. 
    _dirty = NO;
    LogDebug(@"Synchronized field '%@' with model instance value", _fieldId);
}


/* ================================================== Utility Methods =============================================== */

- (void) dealloc {
    [_fieldId release]; 
    [_defaultValue release]; 
    [_datatype release];
    [_label release]; 
    [_hint release];
    [super dealloc];
}
             
- (NSString*) description { 
    return [NSString stringWithFormat:@"Field: id='%@', value='%@'", _fieldId, _value]; 
}
                 



@end
