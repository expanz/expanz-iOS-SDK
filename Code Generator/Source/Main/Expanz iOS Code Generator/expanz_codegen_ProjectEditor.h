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
#import <Foundation/Foundation.h>


@interface expanz_codegen_ProjectEditor : NSObject  {

@private
    NSMutableDictionary* _project;

}

- (id) initWithFilePath:(NSString*)filePath;

@end

/* ================================================================================================================== */
@compatibility_alias ProjectEditor expanz_codegen_ProjectEditor;