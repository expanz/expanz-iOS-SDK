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
#import "expanz_model_Data.h"

SPEC_BEGIN(DataSpec)

describe(@"Object creation", ^{

    it(@"Should allow instantiation with id and source attributes.", ^{
        Data* data = [[Data alloc] initWithDataId:@"customersList" source:@"Customer.ListMe"];
        assertThat(data, notNilValue());
        assertThat(data.dataId, notNilValue());
        assertThat(data.source, notNilValue());
    });



});

SPEC_END