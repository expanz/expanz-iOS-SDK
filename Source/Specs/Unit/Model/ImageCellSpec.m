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
#import "expanz_model_ImageCell.h"

SPEC_BEGIN(ImageCellSpec)

    describe(@"Object creation", ^{
        it(@"should allow creation with cellId and imageUrl attributes", ^{
            ImageCell
                * imageCell = [[ImageCell alloc] initWithCellId:@"mugShot" imageUrl:@"http://www.zzpics.net/jblues"];
            assertThat(imageCell, notNilValue());
            assertThat(imageCell.cellId, equalTo(@"mugShot"));
            assertThat(imageCell.imageUrl, equalTo(@"http://www.zzpics.net/jblues"));
        });
    });

    describe(@"Loading images", ^{

        it(@"should load the image in an asynchronous thead", ^{
            NSString* url = @"https://esaltstorage.blob.core.windows.net/blobs-sales-sales-customer-customerphoto/1?";
            ImageCell* imageCell = [[ImageCell alloc] initWithCellId:@"mugShot" imageUrl:url];
            assertWillHappen(imageCell.image != nil);
        });
    });

    SPEC_END