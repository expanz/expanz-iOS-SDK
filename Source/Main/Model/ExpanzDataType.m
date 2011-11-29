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


#import "ExpanzDataType.h"

ExpanzDataType ExpanzDataTypeFromString(NSString* string) {

    ExpanzDataType dataType;

    if (string == nil) {
        dataType = ExpanzDataTypeNull;
    }
    else if ([[string lowercaseString] isEqualToString:@"string"]) {
        dataType = ExpanzDataTypeString;
    }
    else if ([[string lowercaseString] isEqualToString:@"number"]) {
        dataType = ExpanzDataTypeNumber;
    }
    else if ([[string lowercaseString] isEqualToString:@"blob"]) {
        dataType = ExpanzDataTypeImage;
    }
    else if ([[string lowercaseString] isEqualToString:@"bool"]) {
        dataType = ExpanzDataTypeBool;
    }
    else {
        [NSException
            raise:NSInternalInconsistencyException format:@"There is no DataType corresponding to the string '%@'",
                                                          string];
    }
    return dataType;
}