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


#import <LRResty/LRResty.h>
#import "expanz_model_ImageGridDataCell.h"


@implementation expanz_model_ImageGridDataCell

@synthesize imageUrl = _imageUrl;
@synthesize image = _image;
@synthesize hasAskedImageToLoad = _hasAskedImageToLoad;

/* ================================================== Initializers ================================================== */
- (id) initWithCellId:(NSString*)cellId imageUrl:(NSString*)imageUrl {
    self = [super initWithCellId:cellId];
    if (self) {
        _imageUrl = [imageUrl copy];
        [self loadImage];
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) loadImage {
    self.hasAskedImageToLoad = YES;
    [[LRResty client] get:_imageUrl withBlock:^(LRRestyResponse* response) {
        LogDebug(@"Got image response: %@", [response responseData]);
        if (response.status == 200) {
            self.image = [UIImage imageWithData:[response responseData]];
        }
        else {
            self.image = nil;
        }
    }];
}

@end