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

#import "NSString+ExpanzDataType.h"


SPEC_BEGIN(NSString_ExpanzDataType)

    describe(@"DataType from NSString", ^{
        
        it(@"should return DataTypeNull", ^{
            NSString* foobar = nil; 
            [[theValue([foobar asExpanzDataType]) should] equal:theValue(ExpanzDataTypeNull)];
        });

        it(@"should return DataTypeString", ^{
            [[theValue([@"string" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeString)];
            [[theValue([@"String" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeString)];
            [[theValue([@"STRING" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeString)];
            [[theValue([@"sTrInG" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeString)];
        });

        it(@"should return DataTypeString", ^{
            [[theValue([@"number" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeNumber)];
            [[theValue([@"Number" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeNumber)];
            [[theValue([@"NUMBER" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeNumber)];
            [[theValue([@"nUmBeR" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeNumber)];
        });

        it(@"should return DataTypeImage", ^{
            [[theValue([@"blob" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeImage)];
            [[theValue([@"Blob" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeImage)];
            [[theValue([@"BLOB" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeImage)];
            [[theValue([@"bLoB" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeImage)];
        });

        it(@"should return DataTypeBool", ^{
            [[theValue([@"bool" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeBool)];
            [[theValue([@"Bool" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeBool)];
            [[theValue([@"BOOL" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeBool)];
            [[theValue([@"BoOl" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeBool)];
        });

        it(@"should return DataTypeDate", ^{
            [[theValue([@"date" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeDate)];
            [[theValue([@"Date" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeDate)];
            [[theValue([@"DATE" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeDate)];
            [[theValue([@"dAtE" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeDate)];
        });

        it(@"should return DataTypeDateTime", ^{
            [[theValue([@"datetime" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeDateTime)];
            [[theValue([@"DateTime" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeDateTime)];
            [[theValue([@"DATETIME" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeDateTime)];
            [[theValue([@"dAtEtImE" asExpanzDataType]) should] equal:theValue(ExpanzDataTypeDateTime)];
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