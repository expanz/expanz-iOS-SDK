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

#import "expanz_model_Folder.h"
#import "expanz_model_File.h"

SPEC_BEGIN(FolderSpec)

    describe(@"Object creation", ^{

        it(@"should allow instantiation with folderId, title, hint, buttonTitle, sequence attributes", ^{

            Folder* folder = [[Folder alloc] initWithFolderId:@"123" title:@"Documents" hint:@"Documents about stuff"
                                                  buttonTitle:@"Touch me up inside!" sequence:@"1"];
            [folder shouldNotBeNil];
            [[folder.folderId should] equal:@"123"];
            [[folder.title should] equal:@"Documents"];
            [[folder.hint should] equal:@"Documents about stuff"];
            [[folder.buttonTitle should] equal:@"Touch me up inside!"];
            [[folder.sequence should] equal:@"1"];
        });

    });

    describe(@"Files", ^{

        __block Folder* folder;

        beforeEach(^{
            folder = [[Folder alloc] initWithFolderId:@"123" title:@"Documents" hint:@"Documents about stuff"
                                          buttonTitle:@"Touch me up inside!" sequence:@"1"];
        });

        it(@"should start with an empty collection of files", ^{
            [[[folder files] should] haveCountOf:0];
        });

        it(@"should allow adding files", ^{
            File* file = [[File alloc]
                initWithFileId:@"12345" title:@"The Foobar" hint:@"Foobars be here." fileName:@"foobar.txt"
                      sequence:@"1" type:@"txt" field:@"foobar"];
            [folder addFile:file];
            [[[folder files] should] haveCountOf:1];

            File* another = [[File alloc]
                initWithFileId:@"12345" title:@"The Foobar" hint:@"Foobars be here." fileName:@"foobar.txt"
                      sequence:@"1" type:@"txt" field:@"foobar"];
            [folder addFile:another];

            [[[folder files] should] haveCountOf:2];
        });
    });

SPEC_END


