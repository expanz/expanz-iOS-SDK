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
#import "expanz_model_ActivityInstance.h"
#import "expanz_model_Field.h"
#import "expanz_model_DataSet.h"


SPEC_BEGIN(ActivityInstanceSpec)

    __block ActivityInstance* instance;

    beforeEach(^{
        instance = [[ActivityInstance alloc] initWithTitle:@"Calculator" handle:@"12345" persistentId:@"123"];
    });

    describe(@"Object creation.", ^{

        it(@"should allow initialization with title, handle and persistent id", ^{
            assertThat(instance.title, equalTo(@"Calculator"));
            assertThat(instance.handle, equalTo(@"12345"));
            assertThat(instance.persistentId, equalTo(@"123"));
        });

        it(@"should describe itself", ^{
            assertThat([instance description], equalTo(
                @"Activity Instance: title=Calculator, handle=12345, persistentId=123"));
        });

    });

    describe(@"Relationship to fields", ^{

        it(@"should store a collection of field objects, initially empty.", ^{
            assertThat([instance fields], empty());
        });

        it(@"should allow field references to be added.", ^{
            Field* field = [[Field alloc]
                initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:ExpanzDataTypeNumber label:@"Operand 1"
                           hint:@"Enter a value for operand 1"];
            [instance addField:field];
            [field release];
            assertThatInt([instance.fields count], equalToInt(1));
        });

        it(@"should allow a stored field to be retrieved by fieldId", ^{
            Field* field = [[Field alloc]
                initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:ExpanzDataTypeNumber label:@"Operand 1"
                           hint:@"Enter a value for operand 1"];
            [instance addField:field];
            [field release];

            Field* retrieved = [instance fieldWithId:@"op1"];
            assertThat(retrieved, equalTo(field));

            Field* another = [instance fieldWithId:@"notInMyCollection"];
            assertThat(another, nilValue());
        });
    });

    describe(@"Relationship to DataSets", ^{

        it(@"should hold a collection of DataSets.", ^{
            DataSet* dataSet = [[DataSet alloc] initWithDataId:@"customersList" source:@"ESA.Sales.Customer"];
            [instance addDataSet:dataSet];
        });

        it(@"should allow retrieval of stored DataSets by id", ^{    
            DataSet* dataSet = [[DataSet alloc] initWithDataId:@"customersList" source:@"ESA.Sales.Customer"];
            [instance addDataSet:dataSet];
            DataSet* retrieved = [instance dataSetWithId:@"customersList"];
            assertThat(retrieved, equalTo(dataSet));
        });
    });

    describe(@"Method invocations. . . ", ^{

        it(@"should prevent method invocations, unless all of it's child fields are clean.", ^{

            //Yes if it has no fields.
            assertThatBool([instance allowsMethodInvocations], equalToBool(YES));

            //Yes, if it has one field, that is synched with the server.
            Field* field = [[Field alloc]
                initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:ExpanzDataTypeNumber label:@"Operand 1"
                           hint:@"Enter a value for operand 1"];
            //Field is clean.
            assertThatBool(field.isDirty, equalToBool(NO));
            [instance addField:field];
            [field release];
            assertThatBool([instance allowsMethodInvocations], equalToBool(YES));


            //No, if one ore more fieds are dirty.
            Field* another = [[Field alloc]
                initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:ExpanzDataTypeNumber label:@"Operand 1"
                           hint:@"Enter a value for operand 1"];
            //Make the field dirty.
            [another didFinishEditWithValue:@"One two three"]; assertThatBool([another isDirty], equalToBool(YES));
            [instance addField:another];
            [another release];

            assertThatBool([instance allowsMethodInvocations], equalToBool(NO));

        });
    });


    afterEach(^{
        [instance release];
    });


SPEC_END