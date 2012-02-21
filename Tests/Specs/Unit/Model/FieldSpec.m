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

#import "expanz_model_Field.h"

SPEC_BEGIN(FieldSpec)

    __block Field* field;

    beforeEach(^{
        field = [[Field alloc]
            initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:ExpanzDataTypeNumber label:@"First Name"
                       hint:@"Try typing your name, doh."];
    });

    describe(@"Object creation.", ^{

        it(@"should allow initialization with fieldId, nullable, defaultValue, datatype, label & hint attributes.", ^{
            [[[field fieldId] should] equal:@"op1"];
            [[theValue([field isNullable]) should] beNo];
            [[field defaultValue] shouldBeNil];
            [[theValue([field datatype]) should] equal:theValue(ExpanzDataTypeNumber)];
            [[[field hint] should] equal:@"Try typing your name, doh."];
        });

        it(@"Should be able to describe itslef", ^{
            [[field description] shouldNotBeNil];
            LogDebug(@"Description: %@", [field description]);
        });
    });

    describe(@"Editing", ^{

        it(@"should include a method to set a new value, as a result of user interaction.", ^{
            [field didFinishEditWithValue:@"new value"];
            [[[field value] should] equal:@"new value"];
        });

        it(@"should set a dirty flag to indicate the user changed a value, but the value has not yet been recieved \
       by the server", ^{
            [field didFinishEditWithValue:@"new value"];
            [[theValue(field.isDirty) should] beYes];
        });

    });

    describe(@"synchronizing state with the server/cloud.", ^{

        it(@"should include a method to set a new value, as a result of server processing a delta request.", ^{
            [field didSynchronizeStateWithServerModel:@"new validated value"];
            [[field.value should] equal:@"new validated value"];

        });

        it(@"should revert back to a clean state, after the server has registered the delta. ", ^{
            [field didSynchronizeStateWithServerModel:@"new validated value"];
            [[theValue(field.isDirty) should] beNo];
        });

    });


    SPEC_END