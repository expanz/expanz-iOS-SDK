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
#import "expanz_model_File.h"


SPEC_BEGIN(FileSpec)

    __block File* file;

    beforeEach(^{
        file = [[File alloc]
            initWithFileId:@"1234" title:@"Foobar" hint:@"Something is inside the file." fileName:@"foobar.txt"
                  sequence:@"1" type:@"txt" field:@"foobar"];
    });


    describe(@"Object creation", ^{

        it(@"should allow initialization with fileId, title, hint, fileName, sequence, type & field parameters", ^{

            assertThat(file, notNilValue());
            assertThat(file.fileId, equalTo(@"1234"));
            assertThat(file.title, equalTo(@"Foobar"));
            assertThat(file.hint, equalTo(@"Something is inside the file."));
            assertThat(file.fileName, equalTo(@"foobar.txt"));
            assertThat(file.sequence, equalTo(@"1"));
            assertThat(file.type, equalTo(@"txt"));
            assertThat(file.field, equalTo(@"foobar"));

        });

        it(@"should describe itself", ^{

            assertThat([file description], equalTo(@"File: fileId=1234, title=Foobar, hint=Something is inside the "
                "file., fileName=foobar.txt, sequence=1, type=txt, field=foobar"));

        });

    });



    SPEC_END