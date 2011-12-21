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

#import "expanz_model_Folder.h"
#import "expanz_model_File.h"


@implementation expanz_model_Folder

@synthesize folderId = _folderId;
@synthesize title = _title;
@synthesize hint = _hint;
@synthesize buttonTitle = _buttonTitle;
@synthesize sequence = _sequence;


/* ================================================== Initializers ================================================== */
- (id)initWithFolderId:(NSString*)folderId title:(NSString*)title hint:(NSString*)hint
           buttonTitle:(NSString*)buttonTitle sequence:(NSString*)sequence {

    self = [super init];
    if (self) {
        _folderId = [folderId copy];
        _title = [title copy];
        _hint = [hint copy];
        _buttonTitle = [buttonTitle copy];
        _sequence = [sequence copy];
        _files = [[NSMutableArray alloc] init];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (NSArray*)files {
    NSSortDescriptor* sorter = [NSSortDescriptor sortDescriptorWithKey:@"sequence" ascending:YES];
    return [_files sortedArrayUsingDescriptors:[NSArray arrayWithObject:sorter]];
}

- (void)addFile:(expanz_model_File*)file {
    [_files addObject:file];
}

@end