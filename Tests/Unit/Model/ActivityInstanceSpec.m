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

#import "expanz_model_ActivityInstance.h"
#import "expanz_model_FieldInstance.h"
#import "expanz_model_GridData.h"


SPEC_BEGIN(ActivityInstanceSpec)

    __block ActivityInstance* instance;

    beforeEach(^{
        instance = [[ActivityInstance alloc] initWithTitle:@"Calculator" handle:@"12345" persistentId:@"123"];
    });

    describe(@"Object creation.", ^{

        it(@"should allow initialization with title, handle and persistent id", ^{
            [[[instance title] should] equal:@"Calculator"];
            [[[instance handle] should] equal:@"12345"];
            [[[instance persistentId] should] equal:@"123"];
        });

        it(@"should describe itself", ^{
            [[[instance description] should]
                equal:@"Activity Instance: title=Calculator, handle=12345, persistentId=123"];
        });

    });

    describe(@"Relationship to fields", ^{

        it(@"should store a collection of field objects, initially empty.", ^{
            [[[instance fields] should] beEmpty];
        });

        it(@"should allow field references to be added.", ^{
            FieldInstance* field = [[FieldInstance alloc]
                initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:ExpanzDataTypeNumber label:@"Operand 1"
                           hint:@"Enter a value for operand 1"];
            [instance addField:field];
            [[theValue([instance.fields count]) should] equal:theValue(1)];
        });

        it(@"should allow a stored field to be retrieved by fieldId", ^{
            FieldInstance* field = [[FieldInstance alloc]
                initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:ExpanzDataTypeNumber label:@"Operand 1"
                           hint:@"Enter a value for operand 1"];
            [instance addField:field];

            FieldInstance* retrieved = [instance fieldWithId:@"op1"];
            [[retrieved should] equal:field];

            FieldInstance* another = [instance fieldWithId:@"notInMyCollection"];
            [another shouldBeNil];
        });
    });

    describe(@"Relationship to DataSets", ^{

        it(@"should hold a collection of DataSets.", ^{
            GridData* dataSet = [[GridData alloc] initWithDataId:@"customersList" source:@"ESA.Sales.Customer"];
            [instance addData:dataSet];
        });

        it(@"should allow retrieval of stored DataSets by id", ^{
            GridData* dataSet = [[GridData alloc] initWithDataId:@"customersList" source:@"ESA.Sales.Customer"];
            [instance addData:dataSet];
            GridData* retrieved = (GridData*) [instance dataWithId:@"customersList"];
            [[retrieved should] equal:dataSet];
        });

        it(@"should return nil when asked for a dataset of an id not being stored", ^{
            [[instance dataWithId:@"not.stored"] shouldBeNil];
        });
    });

    describe(@"Method invocations. . . ", ^{

        it(@"should prevent method invocations, unless all of it's child fields are clean.", ^{

            //Yes if it has no fields.
            [[theValue([instance allowsMethodInvocations]) should] beYes];

            //Yes, if it has one field, that is synched with the server.
            FieldInstance* field = [[FieldInstance alloc]
                initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:ExpanzDataTypeNumber label:@"Operand 1"
                           hint:@"Enter a value for operand 1"];
            //Field is clean.
            [[theValue(field.isDirty) should] beNo];
            [instance addField:field];

            [[theValue([instance allowsMethodInvocations]) should] beYes];


            //No, if one ore more fieds are dirty.
            FieldInstance* another = [[FieldInstance alloc]
                initWithFieldId:@"op1" nullable:NO defaultValue:nil dataType:ExpanzDataTypeNumber label:@"Operand 1"
                           hint:@"Enter a value for operand 1"];
            //Make the field dirty.
            [another didFinishEditWithValue:@"One two three"]; 
            [[theValue([another isDirty]) should] beYes];
            [instance addField:another];

            [[theValue([instance allowsMethodInvocations]) should] beNo];

        });
    });


    SPEC_END