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


#import "expanz_model_ImageGridDataCell.h"

SPEC_BEGIN(ImageCellSpec)

    __block ImageGridDataCell* imageCell;

    describe(@"Object creation", ^{
        it(@"should allow creation with cellId and imageUrl attributes", ^{
            imageCell = [[ImageGridDataCell alloc] initWithCellId:@"mugShot" imageUrl:@"http://www.zzpics.net/jblues"];
            [imageCell shouldNotBeNil];
            [[imageCell.cellId should] equal:@"mugShot"];
            [[imageCell.imageUrl should] equal:@"http://www.zzpics.net/jblues"];
        });
    });

    describe(@"Loading images", ^{

        it(@"should load the image in an asynchronous thead", ^{
            NSString* url = @"http://www.google.com.ph/images/srpr/logo3w.png";
            imageCell = [[ImageGridDataCell alloc] initWithCellId:@"mugShot" imageUrl:url];
            assertWillHappen(imageCell.image != nil);
        });
    });

    

    SPEC_END