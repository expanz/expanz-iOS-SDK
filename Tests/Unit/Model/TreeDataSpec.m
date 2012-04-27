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


#import "expanz_model_TreeData.h"
#import "expanz_model_Folder.h"

SPEC_BEGIN(TreeDataSpec)

        describe(@"Object creation", ^{

            it(@"should allow creation with dataId attribute", ^{
                TreeData* treeData = [[TreeData alloc] initWithDataId:@"1234"];
                [treeData shouldNotBeNil];
                [[[treeData dataId] should] equal:@"1234"];

            });
        });

        describe(@"Folders", ^{

            __block TreeData* treeData;

            beforeEach(^{
                treeData = [[TreeData alloc] initWithDataId:@"1234"];
            });

            it(@"should start with an empty collection of folders", ^{
                [[[treeData folders] should] haveCountOf:0];
            });

            it(@"should allow adding folders", ^{
                Folder* folder =
                        [[Folder alloc] initWithFolderId:@"1234" title:nil hint:nil buttonTitle:nil sequence:@"2"];

                [treeData addFolder:folder];
                [[[treeData folders] should] haveCountOf:1];

                Folder* another =
                        [[Folder alloc] initWithFolderId:@"1234" title:nil hint:nil buttonTitle:nil sequence:@"1"];

                [treeData addFolder:another];
                [[[treeData folders] should] haveCountOf:2];
            });

            it(@"should sort folders according to sequence attribute", ^{
                Folder* folder =
                        [[Folder alloc] initWithFolderId:@"1234" title:nil hint:nil buttonTitle:nil sequence:@"2"];
                [treeData addFolder:folder];

                Folder* another =
                        [[Folder alloc] initWithFolderId:@"1234" title:nil hint:nil buttonTitle:nil sequence:@"1"];

                [treeData addFolder:another];

                [[[[treeData folders] objectAtIndex:0] should] equal:another];
                [[[[treeData folders] objectAtIndex:1] should] equal:folder];

            });

            it(@"should provide an accessor to return a folder by id:", ^{
                Folder* folder =
                        [[Folder alloc] initWithFolderId:@"1234" title:nil hint:nil buttonTitle:nil sequence:@"2"];
                [treeData addFolder:folder];

                [[[treeData folderWithId:@"1234"] should] equal:folder];
                [[treeData folderWithId:@"5678"] shouldBeNil];

            });

        });

        SPEC_END