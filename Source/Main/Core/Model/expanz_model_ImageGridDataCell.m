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
#import "expanz_SdkConfiguration.h"


@implementation expanz_model_ImageGridDataCell

@synthesize imageUrl = _imageUrl;
@synthesize imageData = _imageData;
@synthesize hasAskedImageToLoad = _hasAskedImageToLoad;

/* ================================================== Initializers ================================================== */
- (id) initWithCellId:(NSString*)cellId imageUrl:(NSString*)imageUrl {
    self = [super initWithCellId:cellId];
    if (self) {
        if (imageUrl.length > 0) {
            _imageUrl = [[SdkConfiguration globalConfiguration].blobCacheUrl
                    stringByAppendingString:[imageUrl stringByReplacingOccurrencesOfString:@"\\" withString:@"/"]];
        }
    }
    return self;
}

/* ================================================ Interface Methods =============================================== */
- (void) loadImage {
    self.hasAskedImageToLoad = YES;
    if (_imageUrl) {
        [[LRResty client] get:_imageUrl withBlock:^(LRRestyResponse* response) {
            if (response.status == 200) {
                self.imageData = [response responseData];
            }
            else {
                self.imageData = nil;
            }
        }];
    }
}

@end