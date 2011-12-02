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

#import "expanz_model_File.h"

@implementation expanz_model_File

@synthesize fileId = _fileId;
@synthesize title = _title;
@synthesize hint = _hint;
@synthesize fileName = _fileName;
@synthesize sequence = _sequence;
@synthesize type = _type;
@synthesize field = _field;

/* ================================================== Constructors ================================================== */
- (id)initWithFileId:(NSString*)fileId title:(NSString*)title hint:(NSString*)hint fileName:(NSString*)fileName
            sequence:(NSString*)sequence type:(NSString*)type field:(NSString*)field {
    
    self = [super init]; 
    if (self) {
        _fileId = [fileId copy]; 
        _title = [title copy];
        _hint = [hint copy]; 
        _fileName = [fileName copy];
        _sequence = [sequence copy];
        _type = [type copy];
        _field = [field copy];
    }
    return self; 
}

/* ================================================== Utility Methods =============================================== */
- (void) dealloc {
    [_fileId release];
    [_title release];
    [_hint release];
    [_fileName release];
    [_sequence release];
    [_type release];
    [_field release];
    [super dealloc];
}

@end