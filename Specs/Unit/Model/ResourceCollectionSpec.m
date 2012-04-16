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

#import "expanz_model_ResourceCollection.h"
#import "expanz_model_FileResource.h"


SPEC_BEGIN(ResourceCollectionSpec)

    __block ResourceCollection* resourceCollection;

    beforeEach(^{
        resourceCollection = [[ResourceCollection alloc] initWithTitle:@"Documents"];
    });


    describe(@"File resources", ^{

        it(@"should allow adding file resources", ^{

            FileResource
                * fileResource = [[FileResource alloc] initWithPath:@"/blobs/Foobar" ext:@"pdf" field:@"field.foobar"];
            [resourceCollection addFileResource:fileResource];

            [[[resourceCollection fileResources] should] haveCountOf:1];

        });

        it(@"should describe itself", ^{

            [[resourceCollection description] shouldNotBeNil];

        });

    });

    SPEC_END