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

#import "expanz_model_FileResource.h" 


SPEC_BEGIN(FileResourceSpec)

    __block FileResource* fileResource;

    beforeEach(^{
        fileResource = [[FileResource alloc] initWithPath:@"/blobs/Foobar" ext:@"doc" field:@"foobar"];
    });


    describe(@"object creation", ^{

        it(@"should allow initialization with path, ext and field attributes.", ^{

            [fileResource shouldNotBeNil];
            [[fileResource.path should] equal:@"/blobs/Foobar"];
            [[fileResource.ext should] equal:@"doc"];
            [[fileResource.field should] equal:@"foobar"];
        });

        it(@"should describe itself", ^{

            [[[fileResource description] should]
                equal:@"FileResource: path='/blobs/Foobar', ext='doc', field='foobar'"];

        });

    });

    SPEC_END