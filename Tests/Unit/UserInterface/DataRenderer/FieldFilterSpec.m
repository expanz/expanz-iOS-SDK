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

#import "expanz_ui_FieldFilter.h"

SPEC_BEGIN(MyFilterObjectSpec)


        it(@"should collect the names of fields to include", ^{

            FieldFilter* filterObject = [[FieldFilter alloc] init];
            [filterObject setValue:[NSNumber numberWithBool:YES] forKey:@"foo"];
            [filterObject setValue:[NSNumber numberWithBool:YES] forKey:@"bar"];
            [filterObject setValue:[NSNumber numberWithBool:NO] forKey:@"aHooGah"];

            NSArray* fields = [filterObject fields];
            LogDebug(@"Fields: %@", fields);
            [[fields should] haveCountOf:2];
            [[fields should] contain:@"Foo"];
            [[fields should] contain:@"Bar"];
            [[fields shouldNot] contain:@"AHooGah"];
        });



SPEC_END