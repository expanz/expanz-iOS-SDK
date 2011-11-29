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
            assertThatInt([@"string" asExpanzDataType], equalToInt(ExpanzDataTypeString));
            assertThatInt([@"String" asExpanzDataType], equalToInt(ExpanzDataTypeString));
            assertThatInt([@"STRING" asExpanzDataType], equalToInt(ExpanzDataTypeString));
            assertThatInt([@"sTrInG" asExpanzDataType], equalToInt(ExpanzDataTypeString));
        });

        it(@"should return DataTypeString", ^{
            assertThatInt([@"number" asExpanzDataType], equalToInt(ExpanzDataTypeNumber));
            assertThatInt([@"Number" asExpanzDataType], equalToInt(ExpanzDataTypeNumber));
            assertThatInt([@"NUMBER" asExpanzDataType], equalToInt(ExpanzDataTypeNumber));
            assertThatInt([@"nUmBeR" asExpanzDataType], equalToInt(ExpanzDataTypeNumber));
        });

        it(@"should return DataTypeImage", ^{
            assertThatInt([@"blob" asExpanzDataType], equalToInt(ExpanzDataTypeImage));
            assertThatInt([@"Blob" asExpanzDataType], equalToInt(ExpanzDataTypeImage));
            assertThatInt([@"BLOB" asExpanzDataType], equalToInt(ExpanzDataTypeImage));
            assertThatInt([@"bLoB" asExpanzDataType], equalToInt(ExpanzDataTypeImage));
        });

        it(@"should return DataTypeBool", ^{
            assertThatInt([@"bool" asExpanzDataType], equalToInt(ExpanzDataTypeBool));
            assertThatInt([@"Bool" asExpanzDataType], equalToInt(ExpanzDataTypeBool));
            assertThatInt([@"BOOL" asExpanzDataType], equalToInt(ExpanzDataTypeBool));
            assertThatInt([@"BoOl" asExpanzDataType], equalToInt(ExpanzDataTypeBool));
        });

    });

    describe(@"Exception handling", ^{

        __block ExpanzDataType dataType;

        it(@"should throw NSInternalInconsistencyException for unnampped type", ^{
            @try {
                dataType = [@"foobar" asExpanzDataType];
                [NSException raise:@"Should have thrown exception" format:@"foobar isn't an ExpanzDataType"];
            }
            @catch (NSException* e) {
                //Expected behavior.
                LogDebug("%@", [e description]);
            }
        });
    });


    SPEC_END