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
#import "expanz_codegen_ProjectEditor.h"


@implementation expanz_codegen_ProjectEditor

- (id)initWithFilePath:(NSString*)filePath {
    _project = [[NSMutableDictionary alloc] initWithContentsOfFile:filePath];
    LogDebug(@"Here be yer dictionary: %@", _project);
}


@end