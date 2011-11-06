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

typedef enum {
    ExpanzDataTypeString, ExpanzDataTypeNumber, ExpanzDataTypeImage
} ExpanzDataType;


static ExpanzDataType ExpanzDataTypeFromString(NSString* string) {
    if ([[string lowercaseString] isEqualToString:@"string"]) {
        return ExpanzDataTypeString;
    }
    else if ([[string lowercaseString] isEqualToString:@"number"]) {
        return ExpanzDataTypeNumber;
    }
    else if ([[string lowercaseString] isEqualToString:@"blob"]) {
        return ExpanzDataTypeImage;
    }
    else {
        [NSException
            raise:NSInternalInconsistencyException format:@"There is no DataType corresponding to the string '%@'",
                                                          string];
    }
    return 0;
}
