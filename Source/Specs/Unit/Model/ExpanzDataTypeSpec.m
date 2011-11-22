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

#import "SpecHelper.h"
#import "ExpanzDataType.h"


SPEC_BEGIN(ExpanzDataTypeSpec)

    describe(@"DataType from NSString", ^{

        it(@"should return DataTypeString", ^{
            assertThatInt(ExpanzDataTypeFromString(@"string"), equalToInt(ExpanzDataTypeString));
            assertThatInt(ExpanzDataTypeFromString(@"String"), equalToInt(ExpanzDataTypeString));
            assertThatInt(ExpanzDataTypeFromString(@"STRING"), equalToInt(ExpanzDataTypeString));
            assertThatInt(ExpanzDataTypeFromString(@"sTrInG"), equalToInt(ExpanzDataTypeString));
        });

        it(@"should return DataTypeString", ^{
            assertThatInt(ExpanzDataTypeFromString(@"number"), equalToInt(ExpanzDataTypeNumber));
            assertThatInt(ExpanzDataTypeFromString(@"Number"), equalToInt(ExpanzDataTypeNumber));
            assertThatInt(ExpanzDataTypeFromString(@"NUMBER"), equalToInt(ExpanzDataTypeNumber));
            assertThatInt(ExpanzDataTypeFromString(@"nUmBeR"), equalToInt(ExpanzDataTypeNumber));
        });

        it(@"should return DataTypeImage", ^{
            assertThatInt(ExpanzDataTypeFromString(@"blob"), equalToInt(ExpanzDataTypeImage));
            assertThatInt(ExpanzDataTypeFromString(@"Blob"), equalToInt(ExpanzDataTypeImage));
            assertThatInt(ExpanzDataTypeFromString(@"BLOB"), equalToInt(ExpanzDataTypeImage));
            assertThatInt(ExpanzDataTypeFromString(@"bLoB"), equalToInt(ExpanzDataTypeImage));
        });

        it(@"should return DataTypeImage", ^{
            assertThatInt(ExpanzDataTypeFromString(@"bool"), equalToInt(ExpanzDataTypeImage));
            assertThatInt(ExpanzDataTypeFromString(@"Bool"), equalToInt(ExpanzDataTypeImage));
            assertThatInt(ExpanzDataTypeFromString(@"BOOL"), equalToInt(ExpanzDataTypeImage));
            assertThatInt(ExpanzDataTypeFromString(@"BoOl"), equalToInt(ExpanzDataTypeImage));
        });

    });

    describe(@"Exception handling", ^{

        __block ExpanzDataType dataType;

        it(@"should throw NSInternalInconsistencyException for unnampped type", ^{
            @try {
                dataType = ExpanzDataTypeFromString(@"foobar");
                [NSException raise:@"Should have thrown exception" format:@"foobar isn't an ExpanzDataType"];
            }
            @catch (NSException* e) {
                //Expected behavior.
                LogDebug("%@", [e description]);
            }
        });
    });


    SPEC_END