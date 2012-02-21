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

/**
* This fixes a problem related to an Apple implementation of a core unix api.
*/
@interface CoverageFix : NSObject


FILE* fopen$UNIX2003(const char* filename, const char* mode);

size_t fwrite$UNIX2003(const void* ptr, size_t size, size_t nitems, FILE* stream);

@end