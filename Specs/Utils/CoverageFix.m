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
#import "CoverageFix.h"


@implementation CoverageFix

FILE* fopen$UNIX2003(const char* filename, const char* mode) {
    return fopen(filename, mode);
}

size_t fwrite$UNIX2003(const void* ptr, size_t size, size_t nitems, FILE* stream) {
    return fwrite(ptr, size, nitems, stream);
}

@end