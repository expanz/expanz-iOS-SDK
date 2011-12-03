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
#import "expanz_model_TreeData.h"
#import "expanz_model_Folder.h"

SPEC_BEGIN(TreeDataSpec)

    describe(@"Object creation", ^{

        it(@"should allow creation with dataId attribute", ^{
            TreeData* treeData = [[TreeData alloc] initWithDataId:@"1234"];
            assertThat(treeData, notNilValue());
            assertThat(treeData.dataId, equalTo(@"1234"));
            [treeData release];
        });
    });

    describe(@"Folders", ^{

        __block TreeData* treeData;

        beforeEach(^{
            treeData = [[[TreeData alloc] initWithDataId:@"1234"] autorelease];
        });

        it(@"should start with an empty collection of folders", ^{
            assertThatInt([[treeData folders] count], equalToInt(0));
        });

        it(@"should allow adding folders", ^{
            Folder* folder = [[[Folder alloc] initWithFolderId:@"1234" title:nil hint:nil buttonTitle:nil sequence:@"2"]
                autorelease];
            [treeData addFolder:folder];
            assertThatInt([[treeData folders] count], equalToInt(1));

            Folder* another =
                [[[Folder alloc] initWithFolderId:@"1234" title:nil hint:nil buttonTitle:nil sequence:@"1"]
                    autorelease];
            [treeData addFolder:another];
            assertThatInt([[treeData folders] count], equalToInt(2));
        });

        it(@"should sort folders according to sequence attribute", ^{
            Folder* folder = [[[Folder alloc] initWithFolderId:@"1234" title:nil hint:nil buttonTitle:nil sequence:@"2"]
                autorelease];
            [treeData addFolder:folder];
            Folder* another =
                [[[Folder alloc] initWithFolderId:@"1234" title:nil hint:nil buttonTitle:nil sequence:@"1"]
                    autorelease];
            [treeData addFolder:another];

            assertThat([[treeData folders] objectAtIndex:0], equalTo(another));
            assertThat([[treeData folders] objectAtIndex:1], equalTo(folder));
        });

    });

    SPEC_END