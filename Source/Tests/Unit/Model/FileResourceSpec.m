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
#import "expanz_model_FileResource.h" 


SPEC_BEGIN(FileResourceSpec)

    __block FileResource* fileResource;

    beforeEach(^{
        fileResource = [[FileResource alloc] initWithPath:@"/blobs/Foobar" ext:@"doc" field:@"foobar"];
    });


    describe(@"object creation", ^{

        it(@"should allow initialization with path, ext and field attributes.", ^{

            assertThat(fileResource, notNilValue());
            assertThat(fileResource.path, equalTo(@"/blobs/Foobar"));
            assertThat(fileResource.ext, equalTo(@"doc"));
            assertThat(fileResource.field, equalTo(@"foobar"));
        });

        it(@"should describe itself", ^{

            assertThat([fileResource description], equalTo(
                @"FileResource: path='/blobs/Foobar', ext='doc', field='foobar'"));

        });

    });

    SPEC_END