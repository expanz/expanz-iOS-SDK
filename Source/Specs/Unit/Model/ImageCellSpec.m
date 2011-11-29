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

    __block ImageCell* imageCell;

    describe(@"Object creation", ^{
        it(@"should allow creation with cellId and imageUrl attributes", ^{
            imageCell = [[ImageCell alloc] initWithCellId:@"mugShot" imageUrl:@"http://www.zzpics.net/jblues"];
            assertThat(imageCell, notNilValue());
            assertThat(imageCell.cellId, equalTo(@"mugShot"));
            assertThat(imageCell.imageUrl, equalTo(@"http://www.zzpics.net/jblues"));
            [imageCell release];
        });
    });

    describe(@"Loading images", ^{

        it(@"should load the image in an asynchronous thead", ^{
            NSString* url = @"http://www.google.com.ph/images/srpr/logo3w.png";
            imageCell = [[ImageCell alloc] initWithCellId:@"mugShot" imageUrl:url];
            assertWillHappen(imageCell.image != nil);
            [imageCell release];
        });
    });
    
    afterEach(^{
        [imageCell release];
    });
    

    SPEC_END