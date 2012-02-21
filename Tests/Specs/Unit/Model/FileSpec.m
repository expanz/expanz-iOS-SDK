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

            [file shouldNotBeNil];
            [[file.fileId should] equal:@"1234"];
            [[file.title should] equal:@"Foobar"];
            [[file.hint should] equal:@"Something is inside the file."];
            [[file.fileName should] equal:@"foobar.txt"];
            [[file.sequence should] equal:@"1"];
            [[file.type should] equal:@"txt"];
            [[file.field should] equal:@"foobar"];

        });

        it(@"should describe itself", ^{

            [[[file description] should] equal:@"File: fileId=1234, title=Foobar, hint=Something is inside the "
                "file., fileName=foobar.txt, sequence=1, type=txt, field=foobar"];

        });

    });



    SPEC_END