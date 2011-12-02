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


@implementation NSString (ExpanzDataType)


- (ExpanzDataType)asExpanzDataType {

    ExpanzDataType dataType;
    if ([[self lowercaseString] isEqualToString:@"string"]) {
        dataType = ExpanzDataTypeString;
    }
    else if ([[self lowercaseString] isEqualToString:@"number"]) {
        dataType = ExpanzDataTypeNumber;
    }
    else if ([[self lowercaseString] isEqualToString:@"blob"]) {
        dataType = ExpanzDataTypeImage;
    }
    else if ([[self lowercaseString] isEqualToString:@"bool"]) {
        dataType = ExpanzDataTypeBool;
    }
    else if ([[self lowercaseString] isEqualToString:@"date"]) {
        dataType = ExpanzDataTypeDate;
    }
    else if ([[self lowercaseString] isEqualToString:@"datetime"]) {
        dataType = ExpanzDataTypeDateTime;
    }
    else {
        [NSException
            raise:NSInternalInconsistencyException format:@"There is no DataType corresponding to the string '%@'",
                                                          self];
    }
    return dataType;
}

@end


