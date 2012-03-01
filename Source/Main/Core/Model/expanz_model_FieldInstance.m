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

#import "expanz_model_FieldInstance.h"

@implementation expanz_model_FieldInstance

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


/* ================================================== Initializers ================================================== */
- (id) initWithFieldId:(NSString*)fieldId nullable:(BOOL)nullable defaultValue:(NSString*)defaultValue
              dataType:(ExpanzDataType)datatype label:(NSString*)label hint:(NSString*)hint {

    self = [super init];
    if (self) {
        _fieldId = [fieldId copy];
        _nullable = nullable;
        _defaultValue = [defaultValue copy];
        _datatype = datatype;
        _label = [label copy];
        _hint = [hint copy];
    }
    return self;
}


/* ================================================ Interface Methods =============================================== */
- (void) didFinishEditWithValue:(NSString*)value {
    LogDebug(@"%@', did finish edit with new value '%@'", [self description], value);
    _value = value;
    _dirty = YES;

}

- (void) didSynchronizeStateWithServerModel:(NSString*)validatedValue {
    _value = validatedValue;
    _dirty = NO;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"Field: id='%@', value='%@'", _fieldId, _value];
}


@end
